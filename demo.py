import pymysql
import random

# 连接到数据库
conn = pymysql.connect(host='localhost', user='dsci551', password='Dsci-551', db='dsci551')
cursor = conn.cursor()

# 插入学生数据
student_ids = [f"s{i:03}" for i in range(100, 110)]
students = [(sid, f"Student_{sid}", "Program_A") for sid in student_ids]
cursor.executemany("INSERT INTO Student(id, name, program) VALUES(%s, %s, %s)", students)

# 插入教师数据
instructor_ids = [f"r{i:03}" for i in range(200, 205)]
instructors = [(rid, f"Instructor_{rid}", "Department_A") for rid in instructor_ids]
cursor.executemany("INSERT INTO Instructor(id, name, department) VALUES(%s, %s, %s)", instructors)

# 插入课程数据
courses = [("DSCI 351", "Course A", "Spring 2023"),
           ("DSCI 250", "Course B", "Fall 2023"),
           ("DSCI 450", "Course C", "Spring 2023"),
           ("DSCI 455", "Data Analysis", "Fall 2023")]
cursor.executemany("INSERT INTO Course(number, title, semester) VALUES(%s, %s, %s)", courses)

# 插入选课数据
takes = [(random.choice(student_ids), random.choice([course[0] for course in courses]), random.choice(["Spring 2023", "Fall 2023"])) for _ in range(15)]
cursor.executemany("INSERT INTO Take(sid, cno, semester) VALUES(%s, %s, %s)", takes)

# 插入教课数据
teaches = [(random.choice(instructor_ids), random.choice([course[0] for course in courses]), random.choice(["Spring 2023", "Fall 2023"])) for _ in range(8)]
cursor.executemany("INSERT INTO Teach(rid, cno, semester) VALUES(%s, %s, %s)", teaches)

# 插入TA数据
ta_students = random.sample(student_ids, 5)
tas = [(sid, random.randint(10, 20)) for sid in ta_students]
cursor.executemany("INSERT INTO TA(sid, hours) VALUES(%s, %s)", tas)

# 插入助教数据
assists = [(random.choice(ta_students), random.choice([course[0] for course in courses]), random.choice(["Spring 2023", "Fall 2023"])) for _ in range(8)]
cursor.executemany("INSERT INTO Assist(sid, cno, semester) VALUES(%s, %s, %s)", assists)

# 提交事务
conn.commit()

cursor.close()
conn.close()
