using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

namespace ScaleTestEndpoint
{
    public class FetchRecords
    {
        [FunctionName(nameof(FetchDataAsync))]
        public async Task<HttpResponseMessage> FetchDataAsync([HttpTrigger(AuthorizationLevel.Anonymous, "post", Route = "data")] HttpRequestMessage req)
        {
            using var stream = await req.Content.ReadAsStreamAsync();
            var inputData = await JsonSerializer.DeserializeAsync<InputData>(stream);

            var stringContent = new StringContent(JsonSerializer.Serialize(inputData), Encoding.UTF8, "application/json");
            return new HttpResponseMessage(HttpStatusCode.OK) { Content = stringContent };
        }
    }
}
