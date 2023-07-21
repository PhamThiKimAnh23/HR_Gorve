using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

public class Toastr
{
    public static void SucessToast(string Message)
    {
        ScriptManager.RegisterClientScriptBlock(HttpContext.Current.Handler as Page, HttpContext.Current.Handler.GetType()
            , "smodel", "<script>$(document).ready(function () {toastr.success('" + Message + "');   }); </script>", false);
    }
    public static void InfoToast(string Message)
    {
        ScriptManager.RegisterClientScriptBlock(HttpContext.Current.Handler as Page, HttpContext.Current.Handler.GetType()
            , "smodel", "<script>$(document).ready(function () {toastr.info('" + Message + "');   }); </script>", false);
    }

    public static void ErrorToast(string Message)
    {
        ScriptManager.RegisterClientScriptBlock(HttpContext.Current.Handler as Page, HttpContext.Current.Handler.GetType()
            , "smodel", "<script>$(document).ready(function () {toastr.error('" + Message + "');   }); </script>", false);
    }
    public static void WarningToast(string Message)
    {
        ScriptManager.RegisterClientScriptBlock(HttpContext.Current.Handler as Page, HttpContext.Current.Handler.GetType()
            , "smodel", "<script>$(document).ready(function () {toastr.warning('" + Message + "');   }); </script>", false);
    }
}
