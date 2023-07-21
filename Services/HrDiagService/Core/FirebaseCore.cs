namespace HrDiagService.Core
{
    using System;
    using System.IO;
    using System.Net;
    using System.Text;

    /// <summary>
    /// Defines the <see cref="FirebaseCore" />.
    /// </summary>
    public class FirebaseCore
    {
        /// <summary>
        /// The SendNotification.
        /// </summary>
        /// <param name="token">The token<see cref="string"/>.</param>
        /// <param name="_title">The _title<see cref="string"/>.</param>
        /// <param name="_body">The _body<see cref="string"/>.</param>
        /// <param name="Id">The Id<see cref="int"/>.</param>
        /// <param name="_ShopId">The _ShopId<see cref="int"/>.</param>
        /// <param name="_CoachingDate">The _CoachingDate<see cref="string"/>.</param>
        /// <param name="_clickaction">The _clickaction<see cref="string"/>.</param>
        /// <returns>The <see cref="string"/>.</returns>
        public static string SendNotification(string token, string _title, string _body, string _clickaction)
        {
            String sResponseFromServer = "NotStart";
            try
            {
                WebRequest tRequest = WebRequest.Create("https://fcm.googleapis.com/fcm/send");
                tRequest.Method = "post";
                tRequest.Headers.Add(string.Format("Authorization: key={0}", "AAARidUsG8:APA91bHH5iMCJnnfEhRicKI5Z2ATdXSss0_RaQvXu3tDfS0QmU4w7zRViE3ufU9tG7n9Phps4RmUYqx6_1K8WEXeXGqz_R_ZS1SA0x5cDTjSthBZ1qAkTUSMKAso2bfRDbdzc0vU9lSB"));
                tRequest.Headers.Add(string.Format("Sender: id={0}", "30130757233"));
                tRequest.ContentType = "application/json";
                string postbody = "";
                postbody = "{\"to\":\"" + token + "\",\"registration_ids\":null,\"condition\":null,\"collapse_key\":null,\"priority\":1,\"content_available\":true,\"mutable_content\":true,\"delay_while_idle\":true,\"time_to_live\":100,\"restricted_package_name\":null,\"dry_run\":null,\"data\":{\"ClickAction\":\"" + _clickaction + "\"},\"notification\":{\"title\":\"" + _title + "\",\"body\":\"" + _body + "\",\"icon\":null,\"sound\":\"default\",\"tag\":null,\"color\":null,\"click_action\":\"" + _clickaction + "\",\"body_loc_key\":null,\"body_loc_args\":null,\"title_loc_key\":null,\"title_loc_args\":null}}";
                Byte[] byteArray = Encoding.UTF8.GetBytes(postbody);
                tRequest.ContentLength = byteArray.Length;
                using (Stream dataStream = tRequest.GetRequestStream())
                {
                    dataStream.Write(byteArray, 0, byteArray.Length);
                    using (WebResponse tResponse = tRequest.GetResponse())
                    {
                        using (Stream dataStreamResponse = tResponse.GetResponseStream())
                        {
                            if (dataStreamResponse != null) using (StreamReader tReader = new StreamReader(dataStreamResponse))
                                {
                                    sResponseFromServer = tReader.ReadToEnd();
                                }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                sResponseFromServer = ex.Message;
            }

            return sResponseFromServer;
        }
    }
}
