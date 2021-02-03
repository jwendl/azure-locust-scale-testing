from locust import User, task, between
from faker import Faker
import uuid

class MyUser(User):

    @task
    def create_service_request(self):
        fake = Faker()
        headers = {
            "content-type": "application/json"
        }

        payload = {
            "firstName": fake.first_name(),
            "birthDate": fake.date_of_birth()
        }

        self.client.post("/api/servicerequest", json=payload, headers = headers)

        with self.client.get("/", catch_response=True) as response:
            if response.text != "Success":
                response.failure("Got wrong response")
            elif response.elapsed.total_seconds() > 1.0:
                response.failure("Request took too long")

class ApiCaller(User):
    task_set = MyUser
    wait_time = between(3, 25)
