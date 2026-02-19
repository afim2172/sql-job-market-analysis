import csv
import random
from datetime import datetime, timedelta

# Constants for data generation
COMPANY_COUNT = 50
JOB_COUNT = 200
SKILLS_LIST = [
    ('Python', 'Programming'), ('SQL', 'Programming'), ('R', 'Programming'), ('Java', 'Programming'),
    ('AWS', 'Cloud'), ('Azure', 'Cloud'), ('GCP', 'Cloud'),
    ('PostgreSQL', 'Database'), ('MySQL', 'Database'), ('Snowflake', 'Database'), ('Redshift', 'Database'),
    ('Tableau', 'Analyst Tool'), ('Power BI', 'Analyst Tool'), ('Looker', 'Analyst Tool'),
    ('Spark', 'Big Data'), ('Hadoop', 'Big Data'), ('Airflow', 'Big Data'), ('Kafka', 'Big Data')
]

# Generate Companies
companies = []
for i in range(1, COMPANY_COUNT + 1):
    companies.append({
        'company_id': i,
        'name': f'Company_{i}',
        'link': f'https://company{i}.com',
        'link_google': f'https://google.com/search?q=company{i}',
        'thumbnail': f'https://company{i}.com/logo.png'
    })

# Generate Skills
skills_dim = []
for i, (skill, type_) in enumerate(SKILLS_LIST, 1):
    skills_dim.append({
        'skill_id': i,
        'skills': skill,
        'type': type_
    })

# Generate Job Postings
job_postings = []
titles = ['Data Scientist', 'Data Engineer', 'Data Analyst', 'Machine Learning Engineer', 'Analytics Engineer']
locations = ['New York, NY', 'San Francisco, CA', 'Austin, TX', 'Remote', 'London, UK']
schedule_types = ['Full-time', 'Part-time', 'Contract']

start_date = datetime(2023, 1, 1)

for i in range(1, JOB_COUNT + 1):
    posted_date = start_date + timedelta(days=random.randint(0, 365))
    is_remote = random.choice([True, False])
    salary_year = random.randint(70000, 200000)
    
    job_postings.append({
        'job_id': i,
        'company_id': random.randint(1, COMPANY_COUNT),
        'job_title_short': random.choice(titles),
        'job_title': f'Senior {random.choice(titles)}',
        'job_location': 'Anywhere' if is_remote else random.choice(locations),
        'job_via': 'LinkedIn',
        'job_schedule_type': random.choice(schedule_types),
        'job_work_from_home': is_remote,
        'search_location': 'USA',
        'job_posted_date': posted_date.strftime('%Y-%m-%d %H:%M:%S'),
        'job_no_degree_mention': random.choice([True, False]),
        'job_health_insurance': random.choice([True, False]),
        'job_country': 'USA',
        'salary_rate': 'year',
        'salary_year_avg': salary_year,
        'salary_hour_avg': round(salary_year / 2080, 2)
    })

# Generate Skills for Jobs (Many-to-Many)
skills_job_dim = []
for job in job_postings:
    # Assign 1 to 5 random skills to each job
    job_skills_count = random.randint(1, 5)
    selected_skills = random.sample(skills_dim, job_skills_count)
    for skill in selected_skills:
        skills_job_dim.append({
            'job_id': job['job_id'],
            'skill_id': skill['skill_id']
        })

# Function to write CSV
def write_csv(filename, data, keys):
    with open(filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        writer.writerows(data)

# Write files
base_path = 'sql_project/data/'
write_csv(base_path + 'company_dim.csv', companies, companies[0].keys())
write_csv(base_path + 'skills_dim.csv', skills_dim, skills_dim[0].keys())
write_csv(base_path + 'job_postings_fact.csv', job_postings, job_postings[0].keys())
write_csv(base_path + 'skills_job_dim.csv', skills_job_dim, skills_job_dim[0].keys())

print("Data generation complete in sql_project/data/")
