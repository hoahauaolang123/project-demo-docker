﻿using System;
using System.Collections.Generic;
using System.Text;

namespace Web2023_BE.ApplicationCore.Entities
{
    public class PagingResponse
    {
        public int TotalRecord { get; set; }

        public int TotalPage { get; set; }
        public int PageSize { get; set; }

        public int PageNumber { get; set; }
        public object PageData { get; set; }

       
    }
}
