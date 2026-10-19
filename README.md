# zhumakhan-zhassulan-devops

DevOps Fundamentals laboratory work: Linux → Git → GitHub → Docker → Jenkins.

| | |
|---|---|
| Student | Zhumakhan Zhassulan |
| Group | IT2-2308 |
| Student ID | 37359 |
| University | IITU |
| Course | DevOps |

## Structure

```
zhumakhan_zhassulan/
├── app/app.py                          # application that prints student info
├── config/app.conf                     # application configuration
├── logs/                               # runtime logs (ignored by Git)
├── scripts/Zhumakhan_Zhassulan_system.sh  # student + system information
├── scripts/test.sh                     # checks used in the Jenkins "Test" stage
├── Zhumakhan_Zhassulan_info.txt        # student information
├── Dockerfile
├── docker-compose.yml
└── Jenkinsfile
```

## Run

```bash
./scripts/Zhumakhan_Zhassulan_system.sh

docker build -t zhumakhan-zhassulan-devops .
docker run --name zhumakhan-zhassulan-container zhumakhan-zhassulan-devops

docker compose up -d     # http://localhost:8000
docker compose down
```

The Jenkins pipeline (`Jenkinsfile`) runs the stages Checkout → Build → Test → Docker Build → Docker Run.
