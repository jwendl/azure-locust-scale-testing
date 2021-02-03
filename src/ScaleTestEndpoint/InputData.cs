using System;
using System.Text.Json.Serialization;

namespace ScaleTestEndpoint
{
    public class InputData
    {
        [JsonPropertyName("id")]
        public Guid Id { get; set; } = Guid.NewGuid();

        [JsonPropertyName("firstName")]
        public string FirstName { get; set; }

        [JsonPropertyName("birthDate")]
        public DateTime BirthDate { get; set; }
    }
}
