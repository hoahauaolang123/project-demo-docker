﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using Microsoft.AspNetCore.Http;
using Web2023_BE.ApplicationCore.Entities;
using Newtonsoft.Json;

namespace Web2023_BE.ApplicationCore.MiddleWare
{
    public class ErrorHandlingMiddleWare
    {
        private readonly RequestDelegate next;

        public ErrorHandlingMiddleWare(RequestDelegate next)
        {
            this.next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await next(context);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex);
            }
        }

        private static Task HandleExceptionAsync(HttpContext context, Exception ex)
        {
            var code = HttpStatusCode.InternalServerError;
            var result = JsonConvert.SerializeObject(
                new ServiceResult
                {
                    Data = new
                    {
                        devMsg = ex.Message,
                        cusMsg = Properties.Resources.MISA_Error
                    },
                    Messasge = Properties.Resources.MISA_Error,
                    Code = Web2023_BE.Entities.Enums.Exception
                }
                );

            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int)code;

            return context.Response.WriteAsync(result);
        }
    }
}
