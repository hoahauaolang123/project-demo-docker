﻿using Dapper;
using MySqlConnector;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.ComponentModel.DataAnnotations;
using Microsoft.Extensions.Configuration;
using Web2023_BE.Entities;
using Web2023_BE.ApplicationCore.Entities;
using System.ComponentModel;
using System.Threading.Tasks;
using Web2023_BE.ApplicationCore.Extensions;

namespace Web2023_BE.ApplicationCore.Interfaces
{
    public class BaseRepository<TEntity> : IBaseRepository<TEntity>, IDisposable where TEntity : BaseEntity
    {
        #region Declare
        IConfiguration _configuration;
        protected IDbConnection _dbConnection = null;
        string _connectionString = string.Empty;
        protected string _tableName;
        public Type _modelType = null;
        #endregion

        #region Constructer
        public BaseRepository(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("TOEIC365ConnectionString");
            _dbConnection = new MySqlConnection(_connectionString);
            _modelType = typeof(TEntity);
            _tableName = _modelType.GetTableName().ToLowerInvariant();
        }
        #endregion

        #region Methods
        /// <summary>
        /// Lấy tất cả0
        /// </summary>
        /// <returns></returns>
        /// CREATED BY: DVHAI (11/07/2021)
        public async Task<IEnumerable<TEntity>> GetEntities()
        {
            return await GetEntitiesUsingCommandTextAsync();
        }

        /// <summary>
        /// Lấy theo id
        /// </summary>
        /// <param name="entityId"></param>
        /// <returns></returns>
        /// CREATED BY: DVHAI (11/07/2021)
        public async Task<TEntity> GetEntityById(Guid entityId)
        {
            var entity = await GetEntitieByIdUsingCommandTextAsync(entityId.ToString());
            return entity;
        }

        /// <summary>
        /// Xóa theo mã
        /// </summary>
        /// <param name="entityId"></param>
        /// <returns></returns>
        /// CREATED BY: DVHAI (11/07/2021)
        public int Delete(Guid entityId)
        {
            var rowAffects = 0;
            _dbConnection.Open();

            using (var transaction = _dbConnection.BeginTransaction())
            {
                try
                {
                    var keyName = _modelType.GetKeyName();

                    var dynamicParams = new DynamicParameters();
                    dynamicParams.Add($"@v_{keyName}", entityId);

                    var query = new StringBuilder($"DELETE FROM {_tableName} WHERE {keyName}=@v_{keyName}");

                    rowAffects = _dbConnection.Execute(query.ToString(), param: dynamicParams, transaction: transaction, commandType: CommandType.Text);

                    transaction.Commit();
                }
                catch { transaction.Rollback(); }
            }

            //3. Trả về số bản ghi bị ảnh hưởng
            return rowAffects;
        }

        /// <summary>
        /// Thêm bản ghi
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        /// CREATED BY: DVHAI (11/07/2021)
        public async Task<int> Insert(TEntity entity)
        {
            var rowAffects = 0;
            _dbConnection.Open();

            var columnsInDatabase = await GetTableColumnsInDatabase();

            using (var transaction = _dbConnection.BeginTransaction())
            {
                try
                {
                    var query = SqlExtensions.GenerateInsertQuery(_modelType, columnsInDatabase.ToList());

                    if (string.IsNullOrEmpty(query)) return rowAffects;

                    var parameters = _modelType.MappingDbType(entity);

                    rowAffects = await _dbConnection.ExecuteAsync(query, param: parameters, transaction: transaction, commandType: CommandType.Text);

                    transaction.Commit();
                }
                catch (Exception)
                {
                    transaction.Rollback();
                }
            }

            //3.Trả về số bản ghi thêm mới
            return rowAffects;
        }

        /// <summary>
        /// Cập nhập bản ghi
        /// </summary>
        /// <param name="entityId"></param>
        /// <param name="entity"></param>
        /// <returns></returns>
        /// CREATED BY: DVHAI (11/07/2021)
        public async Task<int> Update(Guid entityId, TEntity entity)
        {
            var rowAffects = 0;
            _dbConnection.Open();

            var columnsInDatabase = await GetTableColumnsInDatabase();

            using (var transaction = _dbConnection.BeginTransaction())
            {
                try
                {
                    var query = SqlExtensions.GenerateUpdateQuery(_modelType, columnsInDatabase.ToList());

                    if (string.IsNullOrEmpty(query)) return rowAffects;

                    var keyName = _modelType.GetKeyName();
                    entity.GetType().GetProperty(keyName).SetValue(entity, entityId);

                    var parameters = _modelType.MappingDbType(entity);

                    //3. Kết nối tới CSDL:
                    rowAffects = await _dbConnection.ExecuteAsync(query.ToString(), param: parameters, transaction: transaction, commandType: CommandType.Text);

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                }
            }
            //4. Trả về dữ liệu
            return rowAffects;
        }

        /// <summary>
        /// Lấy thưc thể theo thuộc tính
        /// </summary>
        /// <param name="entity">Thực thể</param>
        /// <param name="property">Thuộc tính trong thực thể</param>
        /// <returns>Thực thể</returns>
        /// CREATED BY: DVHAI 08/07/2021
        public TEntity GetEntityByProperty(TEntity entity, PropertyInfo property)
        {
            //1. Thông tin của trường hiện tại
            var propertyName = property.Name;
            var propertyValue = property.GetValue(entity);

            //2. Thông tin khóa
            var keyName = _modelType.GetKeyName();
            var keyValue = _modelType.GetKeyValue(entity);

            string query = string.Empty;

            //3. Kiểm tra kiểu form
            if (entity.EntityState == EntityState.Add)
                query = $"SELECT * FROM {_tableName} WHERE {propertyName} = '{propertyValue}' AND IsDeleted = FALSE";
            else if (entity.EntityState == EntityState.Update)
                query = $"SELECT * FROM {_tableName} WHERE {propertyName} = '{propertyValue}' AND {keyName} <> '{keyValue}' AND IsDeleted = FALSE";
            else
                return null;

            var entityReturn = _dbConnection.Query<TEntity>(query, commandType: CommandType.Text).FirstOrDefault();
            return entityReturn;
        }

        /// <summary>
        /// Lấy thưc thể theo thuộc tính
        /// </summary>
        /// <param name="propertyName">Thuộc tính</param>
        /// <param name="propertyValue">Giá trị của thuộc tính</param>
        /// <returns>Thực thể</returns>
        /// CREATED BY: DVHAI 08/07/2021
        public IEnumerable<TEntity> GetEntitiesByProperty(string propertyName, object propertyValue)
        {
            string query = $"SELECT * FROM {_tableName} WHERE {propertyName} = '{propertyValue}'";
            var entityReturn = _dbConnection.Query<TEntity>(query, commandType: CommandType.Text);
            return (IEnumerable<TEntity>)entityReturn;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="whereClause"></param>
        /// <returns></returns>
        public async Task<IEnumerable<TEntity>> GetEntitiesFilter(string whereClause, string columnNames = "*", string viewName = "")
        {
            string resource = _tableName;
            if (!string.IsNullOrEmpty(viewName))
            {
                resource = viewName;
            }

            if (columnNames == null) columnNames = "*";
            string query = $"SELECT {columnNames} FROM {resource} WHERE {whereClause}";
            var entityReturn = (IEnumerable<TEntity>)await _dbConnection.QueryAsync<TEntity>(query, commandType: CommandType.Text);
            return entityReturn;
        }


        public async Task<IEnumerable<T>> GetEntitiesFilter<T>(string whereClause, string columnNames = "*", string viewName = "")
        {
            string resource = _tableName;
            if (!string.IsNullOrEmpty(viewName))
            {
                resource = viewName;
            }

            if (columnNames == null) columnNames = "*";
            string query = $"SELECT {columnNames} FROM {resource} WHERE {whereClause}";
            var entityReturn = (IEnumerable<T>)await _dbConnection.QueryAsync<T>(query, commandType: CommandType.Text);
            return entityReturn;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="whereClause"></param>
        /// <returns></returns>
        public async Task<int> CountTotalRecordByClause(string whereClause, string viewName = "")
        {
            string resource = _tableName;
            if (!string.IsNullOrEmpty(viewName))
            {
                resource = viewName;
            }
            string queryTotal = $"SELECT COUNT(*) FROM {resource} WHERE {whereClause}";
            var totalRecord = (int)await _dbConnection.QuerySingleAsync<int>(queryTotal, commandType: CommandType.Text);
            return totalRecord;
        }

        /// <summary>
        /// Đóng kết nối
        /// </summary>
        public void Dispose()
        {
            if (_dbConnection.State == ConnectionState.Open)
            {
                _dbConnection.Close();
            }
        }

        public async Task<IEnumerable<TEntity>> QueryUsingCommandTextAsync(string commandText, object pars = null) => (await _dbConnection.QueryAsync<TEntity>(commandText, param: pars, commandType: CommandType.Text)).ToList();

        /// <summary>
        /// Lấy column trong table
        /// </summary>
        /// <param name="table"></param>
        /// <returns></returns>
        public async Task<IEnumerable<string>> GetTableColumnsInDatabase(string table = "")
        {
            if (string.IsNullOrWhiteSpace(table))
            {
                table = _tableName;
            }

            var query = new StringBuilder($"SELECT COLUMN_NAME FROM information_schema.columns WHERE table_name='{table}'");

            var columns = await _dbConnection.QueryAsync<string>(query.ToString(), commandType: CommandType.Text);

            return columns;
        }

        #endregion

        #region PRIVATE METHODS
        /// <summary>
        /// Lấy tất cả theo command text
        /// </summary>
        /// <returns></returns>
        /// CREATED BY: DVHAI (11/07/2021)
        private async Task<IEnumerable<TEntity>> GetEntitiesUsingCommandTextAsync()
        {
            var query = new StringBuilder($"select * from {_tableName}");
            int whereCount = 0;

            if (_modelType.GetHasDeletedColumn())
            {
                whereCount++;
                query.Append($" where IsDeleted = FALSE");
            }

            var entities = await _dbConnection.QueryAsync<TEntity>(query.ToString(), commandType: CommandType.Text);

            return entities.ToList();
        }

        /// <summary>
        /// Lấy bản ghi theo id dùng command text
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        private async Task<TEntity> GetEntitieByIdUsingCommandTextAsync(string id)
        {
            var query = new StringBuilder($"select * from {_tableName}");
            int whereCount = 0;

            Func<StringBuilder, bool> AppendWhere = (query) => { if (whereCount == 0) query.Append(" where "); return true; };

            var primaryKey = _modelType.GetKeyName();

            if (primaryKey != null)
            {
                AppendWhere(query);
                query.Append($"{primaryKey} = '{id}'");
                whereCount++;
            }

            if (_modelType.GetHasDeletedColumn())
            {
                AppendWhere(query);
                query.Append($"IsDeleted = FALSE");
                whereCount++;
            }

            var entities = await _dbConnection.QueryFirstOrDefaultAsync<TEntity>(query.ToString(), commandType: CommandType.Text);

            return entities;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="procedure"></param>
        /// <param name="pars"></param>
        /// <returns></returns>
        /// <exception cref="NotImplementedException"></exception>
        public async Task<IEnumerable<TEntity>> QueryUsingProcedureAsync(string procedure, object pars = null)
        {
            return (await _dbConnection.QueryAsync<TEntity>(procedure, param: pars, commandType: CommandType.StoredProcedure)).ToList();
        }

        #endregion
    }
}