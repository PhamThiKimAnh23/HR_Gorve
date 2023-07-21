
using HrDiagService.BLL;
using HrDiagService.Core;
using HrDiagService.Entities;
using HrDiagService.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace HrDiagService.Handlers
{
    public class UploadFileHandler : AuthorizationHandler
    {

        public static string getCodeRandom()
        {
            var result = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
            var sourceOTP = new char[6];
            var random = new Random();

            lock (random)
            {
                for (int i = 0; i < sourceOTP.Length; i++)
                {
                    sourceOTP[i] = result[random.Next(result.Length)];
                }
                return new String(sourceOTP);
            }
        }
        public string saveImage(HttpPostedFile file, int? ShopId)
        {
            if (file.ContentLength > 0)
            {
                string dir = Context.Server.MapPath("~/Upload");

                if (!System.IO.Directory.Exists(dir))
                    System.IO.Directory.CreateDirectory(dir);
                dir = Path.Combine(dir, "Images");
                if (!System.IO.Directory.Exists(dir))
                    System.IO.Directory.CreateDirectory(dir);
                dir = Path.Combine(dir, DateTime.Now.ToString("yyyyMMdd"));
                if (!System.IO.Directory.Exists(dir))
                    System.IO.Directory.CreateDirectory(dir);

                string ImageName = Employee.EmployeeId + "_" + file.FileName.Replace(".product", ".jpeg").Replace(".query", ".jpeg");
                var filename = System.IO.Path.Combine(dir, ImageName);
                using (FileStream f = new FileStream(filename, FileMode.OpenOrCreate, FileAccess.ReadWrite))
                {
                    Bitmap bmap = new Bitmap(file.InputStream);
                    Graphics graphics = Graphics.FromImage(bmap);
                    SolidBrush brush = new SolidBrush(Color.Red);
                    graphics.DrawString("[" + ShopId.Value + "] " + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"), new Font(FontFamily.GenericSansSerif, 16f, FontStyle.Bold), brush, (float)1f, (float)1f);
                    bmap.Save(f, System.Drawing.Imaging.ImageFormat.Jpeg);
                    bmap.Dispose();
                    graphics.Dispose();
                    f.Flush();
                    f.Close();
                }
                return ImageName;
            }
            return null;

        }
        public override HttpResponseMessage AuthorizationRequest()
        {

            int EmployeeId = Employee.EmployeeId;
            String FUNCTION = new FieldRequest("FUNCTION");
            String UrlServices = System.Configuration.ConfigurationManager.AppSettings["UrlServices"];

            if ("CREATEBILL".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string rootImage = UrlServices + "/" + "Upload/Images/" + DateTime.Now.ToString("yyyyMMdd") + "/";
                    int? ShopId = new FieldRequest("ShopId");
                    string CusName = new FieldRequest("CusName");
                    int? CusSex = new FieldRequest("CusSex");
                    string CusAddress = new FieldRequest("CusAddress");
                    string CusMobile = new FieldRequest("CusMobile");
                    int? MiniGame = new FieldRequest("MiniGame");
                    string MiniGameComment = new FieldRequest("MiniGameComment");
                    int? ProductId = new FieldRequest("ProductId");
                    string PayMethod = new FieldRequest("PayMethod");
                    int? LuckyRaw = new FieldRequest("LuckyRaw");
                    string BillSeri = new FieldRequest("BillSeri");
                    double? Amount = new FieldRequest("Amount");

                    var ImageBill = Context.Request.Files["ImageBill"];
                    var ImageCusReGift = Context.Request.Files["ImageCusReGift"];

                    string error = null;
                    if (LuckyRaw == 5)
                    {
                        error = "Khách hàng có quay Lucky Raw không ?";
                    }
                    else if(LuckyRaw == 1)
                    {
                        if (string.IsNullOrWhiteSpace(CusName))
                        {
                            error = "Bạn chưa nhập tên khách hàng !";
                        }
                        else if (CusSex == 5)
                        {
                            error = "Bạn giới tính khách hàng !";
                        }
                        else if (string.IsNullOrWhiteSpace(CusMobile))
                        {
                            error = "Bạn chưa nhập số điện thoại khách hàng !";
                        }
                        else if (string.IsNullOrWhiteSpace(BillSeri))
                        {
                            error = "Bạn chưa nhập mã đơn hàng !";
                        }
                        else if (Amount == null || (Amount != null && Amount <= 0))
                        {
                            error = "Tổng tiền không hợp lệ vui lòng kiểm tra lại !";
                        }
                        else if (MiniGame == 5)
                        {
                            error = "Khách hàng có chơi Mini Game không ?";
                        }
                        else if (MiniGame != 5 && MiniGame == 1 && string.IsNullOrWhiteSpace(MiniGameComment))
                        {
                            error = "Bạn chưa nhập quà tặng Mini Game !";
                        }
                        else if (string.IsNullOrWhiteSpace(PayMethod))
                        {
                            error = "Bạn chưa nhập phương thức thanh toán !";
                        }
                        else if (ProductId == null)
                        {
                            error = "Bạn chưa chọn sản phẩm !";
                        }
                        else if (ImageBill == null)
                        {
                            error = "Bạn chưa chụp hình hoá đơn !";
                        }
                        else if (ImageCusReGift == null)
                        {
                            error = "Bạn chưa chụp hình khách hàng nhận quà !";
                        }
                    }
                    else if(LuckyRaw == 0)
                    {
                        if (string.IsNullOrWhiteSpace(CusName))
                        {
                            error = "Bạn chưa nhập tên khách hàng !";
                        }
                        else if (CusSex == 5)
                        {
                            error = "Bạn giới tính khách hàng !";
                        }
                        else if (string.IsNullOrWhiteSpace(CusMobile))
                        {
                            error = "Bạn chưa nhập số điện thoại khách hàng !";
                        }
                       
                    }

                    if (string.IsNullOrWhiteSpace(error))
                    {
                        int BillDate = Int32.Parse(DateTime.Now.ToString("yyyyMMdd"));
                        string LuckyRawCode = null;
                        if (LuckyRaw == 1)
                        {
                            LuckyRawCode = getCodeRandom();
                        }
                        string ImageBillPath = rootImage + saveImage(ImageBill, ShopId);
                        string ImageCusReGiftPath = rootImage + saveImage(ImageCusReGift, ShopId);
                        DataSet dataSet =  WorkController.CreateBill(ShopId, EmployeeId, BillDate, CusName, CusSex, CusAddress, CusMobile, MiniGame, MiniGameComment, ProductId, PayMethod, ImageBillPath, ImageCusReGiftPath, LuckyRaw, LuckyRawCode, BillSeri, Amount);
                        DataTable table = dataSet.Tables[0];
                        int statusCode = Convert.ToInt32(table.Rows[0]["StatusCode"].ToString());
                        string content = table.Rows[0]["Content"].ToString();
                        if (statusCode == 200) {
                            if (LuckyRaw != 5 && LuckyRaw == 1)
                            {
                                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Tạo hoá đơn thành công, mã số may mắn của bạn là: " + LuckyRawCode);
                            }
                            else
                            {
                                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Tạo hoá đơn thành công !");
                            }
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, content);
                        }
                       
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, error);
                    }


                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);

                }

            }


            if ("ATTENDANT".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase) || "PHOTO".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    DateTime? ImageTime = new FieldRequest("ImageTime") { Format = "MM/dd/yyyy HH:mm:ss" };
                    int? ShopId = new FieldRequest("ShopId");
                    string ImageName = new FieldRequest("ImageName");
                    string dir = Context.Server.MapPath("~/Upload");

                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "Images");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, ImageTime.Value.ToString("yyyyMMdd"));
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    if (Context.Request.Files.Count > 0)
                    {
                        var file = Context.Request.Files[0];
                        ImageName = EmployeeId + "_" + ImageName.Replace(".product", ".jpeg").Replace(".query", ".jpeg");
                        if (file != null)
                        {
                            if (file.ContentLength > 0)
                            {
                                var filename = System.IO.Path.Combine(dir, ImageName);
                                using (FileStream f = new FileStream(filename, FileMode.OpenOrCreate, FileAccess.ReadWrite))
                                {
                                    Bitmap bmap = new Bitmap(file.InputStream);
                                    Graphics graphics = Graphics.FromImage(bmap);
                                    SolidBrush brush = new SolidBrush(Color.Red);
                                    graphics.DrawString("[" + ShopId.Value + "] " + ImageTime.Value.ToString("dd/MM/yyyy HH:mm:ss"), new Font(FontFamily.GenericSansSerif, 16f, FontStyle.Bold), brush, (float)1f, (float)1f);
                                    bmap.Save(f, System.Drawing.Imaging.ImageFormat.Jpeg);
                                    bmap.Dispose();
                                    graphics.Dispose();
                                    f.Flush();
                                    f.Close();
                                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Tải ảnh thành công !");
                                }
                            }
                            else
                            {
                                Logs.w(EmployeeId.ToString(), ShopId + "", ImageName + "' file empty.", 500);
                                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");

                            }
                        }
                        else
                        {
                            Logs.w(EmployeeId.ToString(), ShopId + "", ImageName + "' not found.", 500);
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File not found !");

                        }
                    }
                    else
                    {
                        Logs.w(EmployeeId.ToString(), ShopId + "", ImageName + "' not found.", 590);
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File not found !");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);

                }

            }
            if ("AUDIO".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string AudioName = new FieldRequest("AudioName");
                    string dir = Context.Server.MapPath("~/Upload");

                    //if (!System.IO.Directory.Exists(dir))
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "Audios");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    if (Context.Request.Files.Count > 0)
                    {
                        AudioName = EmployeeId + "_" + AudioName;
                        var file = Context.Request.Files[0];
                        if (file != null && file.ContentLength > 0)
                        {
                            file.SaveAs(dir + "/" + AudioName);
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, "Tải file thành công !");
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }

            }

            if ("PHOTO_SHOP".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string ImageName = new FieldRequest("ImageName");
                    string dir = Context.Server.MapPath("~/Upload");
                    DateTime? ImageTime = new FieldRequest("ImageTime") { Format = "MM/dd/yyyy HH:mm:ss" };
                    if (!System.IO.Directory.Exists(dir))
                        if (!System.IO.Directory.Exists(dir))
                            System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "ShopImages");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    dir = Path.Combine(dir, ImageTime.Value.ToString("yyyyMMdd"));
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);


                    if (Context.Request.Files.Count > 0)
                    {
                        ImageName = EmployeeId + "_" + ImageName;
                        var file = Context.Request.Files[0];
                        if (file != null && file.ContentLength > 0)
                        {
                            file.SaveAs(dir + "/" + ImageName);
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, UrlServices + "/Upload/ShopImages/" + ImageTime.Value.ToString("yyyyMMdd") + "/" + ImageName);
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            if ("PHOTO_APPLE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    int? AttendantType = new FieldRequest("AttendantType");
                    int? ShopId = new FieldRequest("ShopId");
                    double? latitude = new FieldRequest("latitude");
                    double? longitude = new FieldRequest("longitude");
                    double? accuracy = new FieldRequest("accuracy");
                    string Address = new FieldRequest("Address");
                    int? WorkDate = new FieldRequest("WorkDate");
                    string WorkTime = new FieldRequest("WorkTime");

                    string ImageName = DateTime.Now.ToString("yyyyMMddHHmmss") + ".jpeg";
                    string dir = Context.Server.MapPath("~/Upload");
                    DateTime ImageTime = DateTime.Now;
                    if (!System.IO.Directory.Exists(dir))
                        if (!System.IO.Directory.Exists(dir))
                            System.IO.Directory.CreateDirectory(dir);
                    dir = Path.Combine(dir, "Images");
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);

                    dir = Path.Combine(dir, ImageTime.ToString("yyyyMMdd"));
                    if (!System.IO.Directory.Exists(dir))
                        System.IO.Directory.CreateDirectory(dir);


                    if (Context.Request.Files.Count > 0)
                    {
                        ImageName = EmployeeId + "_" + ImageName;
                        var file = Context.Request.Files[0];
                        if (file != null && file.ContentLength > 0)
                        {
                            file.SaveAs(dir + "/" + ImageName);
                            string pto = UrlServices + "/Upload/Images/" + ImageTime.ToString("yyyyMMdd") + "/" + ImageName;
                            List<AttendanceNewInfo> list = WorkController.Attendance_Apple_ActionV3(EmployeeId, ShopId.Value, AttendantType.Value, latitude, longitude, accuracy, Address, pto, WorkDate.Value, WorkTime, 1);
                            if (list != null && list.Count > 0)
                            {
                                if (list[0].AttendantType == -1)
                                {
                                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, list[0].PhotoServer);
                                }
                                else
                                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, list);
                            }
                            else
                            {
                                return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "Không có dữ liệu");
                            }
                            //using (DataSet ds = WorkController.Attendance_Apple_Action(EmployeeId, ShopId.Value, AttendantType.Value, latitude, longitude, accuracy, Address, pto, WorkDate.Value, WorkTime, 1))
                            //{
                            //    if (ds.Tables[0].Columns.Count == 1)
                            //    {
                            //        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ds.Tables[0].Rows[0]["content"]);
                            //    }
                            //    else
                            //    {
                            //        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, ds.Tables[0]);
                            //    }
                            //}
                        }
                        else
                        {
                            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                        }
                    }
                    else
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "File empty!");
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            if ("GET_PHOTO_APPLE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    int? ShopId = new FieldRequest("ShopId");
                    int? WorkDate = new FieldRequest("WorkDate");
                    int? AttendantType = new FieldRequest("AttendantType");

                    List<AttendanceNewInfo> list = WorkController.Attendance_Apple_GetListV3(EmployeeId, ShopId.Value, WorkDate.Value);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, list);
                    //using (DataSet ds = WorkController.Attendance_Apple_GetList(EmployeeId, ShopId.Value, AttendantType.Value, null, null, null, null, null, WorkDate.Value, null, 2))
                    //{
                    //    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, ds.Tables[0]);
                    //}
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            if ("APPLE_EMPLOYEE".Equals(FUNCTION, StringComparison.InvariantCultureIgnoreCase))
            {
                try
                {
                    string Email = new FieldRequest("Email");
                    string PassWord = new FieldRequest("PassWord");
                    string OTP = new FieldRequest("OTP");//1: Create or Save; 2:Send OTP;3:Delete Account
                    int? ActionType = new FieldRequest("ActionType");
                    if (!string.IsNullOrEmpty(PassWord))
                        PassWord = SecurityUtils.Encrypt(PassWord);

                    string[] saAllowedCharacters = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };
                    string sRandomOTP = GenerateRandomOTP(6, saAllowedCharacters);
                    if (ActionType.Value == 3)
                        OTP = sRandomOTP;

                    using (DataSet ds = WorkController.Employee_Apple_Action(Email, PassWord, OTP, ActionType.Value))
                    {
                        return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.OK, ds.Tables[0]);
                    }
                }
                catch (Exception ex)
                {
                    Logs.w(EmployeeId.ToString(), ex.Message, ex.StackTrace, 590);
                    return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, ex.Message);
                }
            }
            return HttpResponseMessage.CreateResponse(System.Net.HttpStatusCode.InternalServerError, "FUNCTION NOT FOUND !");

        }
        private string GenerateRandomOTP(int iOTPLength, string[] saAllowedCharacters)

        {

            string sOTP = String.Empty;

            string sTempChars = String.Empty;

            Random rand = new Random();

            for (int i = 0; i < iOTPLength; i++)

            {

                int p = rand.Next(0, saAllowedCharacters.Length);

                sTempChars = saAllowedCharacters[rand.Next(0, saAllowedCharacters.Length)];

                sOTP += sTempChars;

            }

            return sOTP;

        }
    }
}