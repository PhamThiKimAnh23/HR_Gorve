using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using HrDiagService.Data;
using HrDiagService.Entities;
using System.Data;
using System.Data.SqlClient;
using DAUltility.Helpers;

namespace HrDiagService.BLL
{
    public static class ProductsController
    {
        public static List<ProductInfo> Filter()
        {
            List<ProductInfo> list = null;
            using (var context = new ProductsContext())
            {
                var _list = context.Filter();
                if (_list != null)
                    list = _list.ToList();
            }
            return list;
        }
		public static List<KPIPosmInfo> PostList(int EmployeeId)
		{
			List<KPIPosmInfo> list = null;
			using (var context = new ProductsContext())
			{
				var _list = context.PostGetList(EmployeeId);
				if (_list != null)
					list = _list.ToList();
			}
			return list;
		}
		public static DataSet GetRequest(string EmployeeCode, string RequestId)
        {
            return SqlHelper.ExecuteDataset(CommandType.StoredProcedure, "[dbo].[Mobile.GetRequest]");
        }
    }
}
