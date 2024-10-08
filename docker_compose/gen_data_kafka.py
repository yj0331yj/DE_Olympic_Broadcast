import time
import requests
from confluent_kafka import Producer
import json

# KAFKA_TOPIC = 'airflow2kafka0'
KAFKA_TOPIC = 'test-topic'
KAFKA_BOOTSTRAP_SERVERS = '172.31.14.224:9092,172.31.12.74:9092,172.31.11.125:9092'
# KAFKA_BOOTSTRAP_SERVERS = '172.31.14.224:9092'

def gen_data() -> list[str]:
    lyrics = [
        "그대 기억이 지난 사랑이",
        "내 안을 파고드는 가시가 되어",
        "제발 가라고 아주 가라고",
        "애써도 나를 괴롭히는데",
        "너 없는 지금도 눈부신 하늘과",
        "눈부시게 웃는 사람들",
        "나의 헤어짐은 모르는 세상은",
        "슬프도록 그대로인데",
        "시간마저 데려가지 못하게",
        "나만은 널 보내지 못했나 봐",
        "가시처럼 깊게 박힌 기억은",
        "아파도 아픈 줄 모르고",
        "그대 기억이 지난 사랑이",
        "내 안을 파고드는 가시가 되어",
        "제발 가라고 아주 가라고",
        "애써도 나를 괴롭히는데",
        "너무 사랑했던 나를",
        "크게 두려웠던 나를",
        "미치도록 너를 그리워했던",
        "날 이제는 놓아줘",
        "보이지 않아 내 안에 숨어",
        "잊으려 하면 할수록 더 아파와",
        "제발 가라고 아주 가라고",
        "애써도 나를 괴롭히는데"
    ]
    return lyrics


def send_data_to_kafka(data: str) -> None:
    producer = Producer({'bootstrap.servers': KAFKA_BOOTSTRAP_SERVERS})

    def delivery_report(err, data):
        if err is not None:
            print('Message delivery failed: {}'.format(err))
        else:
            print('Message delivered to {}'.format(data))

    producer.produce(KAFKA_TOPIC, value=data, callback=delivery_report)
    # value : str
    producer.poll(1)
    producer.flush()


if __name__ == '__main__':
    try:
        while True:
            datas = gen_data()
            for data in datas:
                send_data_to_kafka(data)
                print(data)
                time.sleep(2)
            time.sleep(1)
    except KeyboardInterrupt:
        print("프로그램이 중지되었습니다.")