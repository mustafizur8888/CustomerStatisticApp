using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using DAL;
using Newtonsoft.Json;

namespace CustomerStaApp.Handler
{
    /// <summary>
    /// Summary description for GetProductValidNonvalidDataHandler
    /// </summary>
    public class GetProductValidNonvalidDataHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";

            string Recency = context.Request.QueryString["Recency"];
            string Frequency = context.Request.QueryString["Frequency"];
            string Monetary = context.Request.QueryString["Monetary"];
            string DataType = context.Request.QueryString["DataType"];
            string Rating = context.Request.QueryString["Rating"];


            string json = new StreamReader(context.Request.InputStream).ReadToEnd();
            json= json.Replace("[", string.Empty).Replace("]", string.Empty).Replace("\"", string.Empty);
            json = HttpUtility.HtmlDecode(json);
            Db db = new Db();

            List<SqlParameter> list = new List<SqlParameter>
            {
                new SqlParameter
                {
                    ParameterName = "@Recency",
                    Value = Recency
                },
                new SqlParameter
                {
                    ParameterName = "@Frequency",
                    Value = Frequency
                },
                new SqlParameter
                {
                    ParameterName = "@Monetary",
                    Value = Monetary
                }
                ,new SqlParameter
                {
                    ParameterName="@Title",
                    Value = json.Replace("[",string.Empty).Replace("]",string.Empty).Replace("\"",string.Empty)
                },
                new SqlParameter
                {
                    ParameterName="@DataType",
                    Value = DataType
                }, new SqlParameter
                {
                    ParameterName="@Rating",
                    Value = Rating
                }

            };
            DataSet dataSet = null;


            dataSet = db.GetDataSet("spGetProductValidNonvalidData", list);

            // string valid = dataSet.Tables[0].Rows[0][0].ToString();
            // string nonvalid = dataSet.Tables[1].Rows[0][0].ToString();
            //string resjson = "{\"valid\":" + valid + ",\"nonvalid\":" + nonvalid + "}";


            string valid = string.Empty;
            string nonvalid = string.Empty;

            valid = DataTableToJsonWithJsonNet(dataSet.Tables[0]); ;



            nonvalid = DataTableToJsonWithJsonNet(dataSet.Tables[1]); ;

            string resjson = "{\"valid\":" + valid + ",\"nonvalid\":" + nonvalid + "}";

            context.Response.Write(resjson);

        }

        public string DataTableToJsonWithJsonNet(DataTable table)
        {
            var jsonString = JsonConvert.SerializeObject(table);
            return jsonString;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}