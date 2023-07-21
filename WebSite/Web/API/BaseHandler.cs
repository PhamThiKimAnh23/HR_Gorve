using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace HR_Grove_Web.API
{
    public abstract class BaseHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        public string UniqueId(int maxSize = 10)
        {
            char[] chars = new char[36];
            string a = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            chars = a.ToCharArray();
            int size = maxSize;
            byte[] data = new byte[1];
            RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
            crypto.GetNonZeroBytes(data);
            size = maxSize;
            data = new byte[size];
            crypto.GetNonZeroBytes(data);
            StringBuilder result = new StringBuilder(size);
            foreach (byte b in data)
            {
                result.Append(chars[b % (chars.Length - 1)]);
            }
            return result.ToString();
        }
        private HttpContext _Context = null;

        public HttpContext Context
        {
            get { return _Context; }
            set { _Context = value; }
        }

        #region IHttpHandler Members

        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            _Context = context;
            try
            {
                ProcessRequest();
            }
            catch (Exception e)
            {
                ReturnError(e.Message);
                throw e;
            }
        }

        public abstract void ProcessRequest();
        public void ReturnJSON<T>(T json)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json);
            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 202;
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.Write(strs);
        }
        public void _ReturnJSON<T>(List<T> json)
        {
            string strs = "[]";
            if (json != null)
            {
                System.Web.Script.Serialization.JavaScriptSerializer convert = new System.Web.Script.Serialization.JavaScriptSerializer();
                strs = convert.Serialize(json);

            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 202;
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.Write(strs);
        }
        public void ReturnJSON<T>(T json, Formatting formatting)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json, formatting);
            }
            _Context.Response.Clear();
            _Context.Response.ContentType = "application/json";
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.StatusCode = 202;
            _Context.Response.Write(strs);
        }
        public void ReturnJSON(DataTable json)
        {
            string strs = "{}";
            if (json != null)
            {
                strs = JsonConvert.SerializeObject(json, Formatting.Indented);
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "application/json";
            _Context.Response.StatusCode = 202;
            _Context.Response.Write(strs);
        }
        public String _GET(string name) { return Context.Request.QueryString[name]; }
        public String _POST(string name) { return Context.Request.Form[name]; }
        public String _HEAD(string name) { return Context.Request.Headers[name]; }
        public void ReturnString(Object value)
        {
            string strs = null;
            if (value != null)
            {
                strs = value.ToString();
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "text/plain";
            Context.Response.StatusCode = 202;
            if (strs != null)
            {
                _Context.Response.OutputStream.Flush();
                byte[] data = System.Text.Encoding.UTF8.GetBytes(strs);
                _Context.Response.OutputStream.Write(data, 0, data.Length);
            }

        }
        public void ReturnError(Object value)
        {
            string strs = null;
            if (value != null)
            {
                strs = value.ToString();
            }
            _Context.Response.Clear();
            _Context.Response.ContentEncoding = System.Text.Encoding.UTF8;
            _Context.Response.ContentType = "text/plain";
            Context.Response.StatusCode = 500;
            _Context.Response.Write(strs);
        }
        public T GetObjectFromJSON<T>(string json) where T : new()
        {
            return JsonConvert.DeserializeObject<T>(json);
        }
        #endregion
    }
}