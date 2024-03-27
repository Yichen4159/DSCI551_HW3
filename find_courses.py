import pymysql
import sys


def find_courses(student_id):
    # Connect to MySQL
    connection = pymysql.connect(
        host='localhost',
        user='dsci551',
        password='Dsci-551',
        db='dsci551'
    )

    try:
        with connection.cursor() as cursor:
            # Query for Student
            sql_student = "SELECT name, program FROM Student WHERE id = %s"
            cursor.execute(sql_student, (student_id,))
            student_info = cursor.fetchone()

            if not student_info:
                print(f"No student found with ID: {student_id}")
                return

            name, program = student_info
            print(f"Student ID: {student_id}\nName: {name}\nProgram: {program}")
            print("\nCourses taken:")

            # Query for courses student take
            sql_courses = """
            SELECT Course.title, Take.semester
            FROM Course JOIN Take ON Course.number = Take.cno
            WHERE Take.sid = %s
            """
            cursor.execute(sql_courses, (student_id,))
            courses = cursor.fetchall()

            for title, semester in courses:
                print(f"Title: {title}, Semester: {semester}")

    finally:
        connection.close()


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 find_courses.py STUDENT_ID")
    else:
        student_id = sys.argv[1]
        find_courses(student_id)
