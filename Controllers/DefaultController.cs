using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace TestCICDAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DefaultController : ControllerBase
    {
        // GET: api/Default
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        [HttpGet]
        [Route("index")]
        public string Index()
        {
            string ret = "";

            try
            {
                ret = "Current Version: " + GetType().Assembly.GetName().Version.ToString();

            }
            catch (Exception)
            {
                ret = "Ver. 148";
            }

            

            return ret;

        }

    }
}
