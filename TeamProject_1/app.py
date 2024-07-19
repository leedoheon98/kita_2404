from flask import Flask, render_template, request, redirect, url_for, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_wtf import FlaskForm
from wtforms import StringField, TextAreaField, DateField
from wtforms.validators import DataRequired
from datetime import datetime
from flask import jsonify
from datetime import datetime
import folium
from folium.features import DivIcon
import json
import pandas as pd
from utils import get_book_recommendations
import csv
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from io import BytesIO
from matplotlib import gridspec
import base64
import matplotlib.font_manager as fm

# 한글 폰트 경로를 지정하세요 (예: 나눔고딕)
font_path = 'static/NanumBarunGothic.ttf'  
font_prop = fm.FontProperties(fname=font_path)
plt.rcParams['font.family'] = font_prop.get_name()

app = Flask(__name__)
app.config.from_pyfile("config.py")
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///tasks.db'  # SQLite 데이터베이스 설정

db = SQLAlchemy(app)
csv_file = 'static/population.csv'
geojson_file = 'static/TL_SCCO_CTPRVN.json'
book_csv_file = 'static/book_store.csv'

# Task 모델 정의
class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    contents = db.Column(db.Text, nullable=False)
    input_date = db.Column(db.DateTime, default=datetime.utcnow)
    due_date = db.Column(db.Date, nullable=False)

# WTForms를 사용한 작업 추가 폼 정의
class TaskForm(FlaskForm):
    title = StringField('제목', validators=[DataRequired()])
    contents = TextAreaField('내용', validators=[DataRequired()])
    due_date = DateField('마감일', validators=[DataRequired()])

# 라우트 및 뷰 함수 정의
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/home')
def back_home():
    return render_template('initial.html')

@app.route('/overview')
def overview():
    return render_template('overview.html')

@app.route('/publisher_service')
def publisher_service():
    return render_template('publisher_service.html')

@app.route('/customer_info')
def customer_info():
    return render_template('customer_info.html')

@app.route('/books_store_info')
def books_store_info():
    return render_template('books_store_info.html')

@app.route('/target_customer')
def target_customer():
    return render_template('target_customer.html')

@app.route('/reader_service')
def reader_service():
    return render_template('reader_service.html')

@app.route('/recommend', methods=['POST'])
def recommend():
    user_gender = request.form['gender']
    user_age = int(request.form['age'])
    result = get_book_recommendations(user_gender, user_age)
    if result:
        recommendations = result.split('\n')
        return jsonify({'recommendations': recommendations})
    else:
        return jsonify({'recommendations': ["추천 도서를 찾을 수 없습니다."]})


@app.route('/inquiry', methods=['GET', 'POST'])
def inquiry():
    form = TaskForm()

    # 현재 날짜를 먼저 정의하고 시작합니다.
    now = datetime.now()

    if request.method == 'POST':
        if form.validate_on_submit():
            title = form.title.data
            contents = form.contents.data

            # 작성일을 현재 날짜로 설정합니다.
            new_task = Task(title=title, contents=contents, input_date=now, due_date=now)
            db.session.add(new_task)
            db.session.commit()

            tasks = Task.query.all()  # 새로운 task가 추가된 후에 전체 tasks를 가져옵니다.
            return render_template('inquiry.html', form=form, tasks=tasks, now=now)
        else:
            errors = {field: form.errors[field][0] for field in form.errors}
            return jsonify({'success': False, 'errors': errors}), 400

    # GET 요청 처리
    tasks = Task.query.all()
    return render_template('inquiry.html', form=form, tasks=tasks, now=now)

@app.route('/tasks', methods=['GET'])
def get_tasks():
    tasks = Task.query.all()
    task_list = []
    for task in tasks:
        task_list.append({
            'id': task.id,
            'title': task.title,
            'contents': task.contents,
            'input_date': task.input_date.strftime('%Y-%m-%d %H:%M:%S'),
            'due_date': task.due_date.strftime('%Y-%m-%d')
        })
    return jsonify(task_list)

@app.route('/edit/<int:task_id>', methods=['GET', 'POST'])
def edit_task(task_id):
    task = Task.query.get_or_404(task_id)
    form = TaskForm(obj=task)
    if form.validate_on_submit():
        task.title = form.title.data
        task.contents = form.contents.data
        task.due_date = form.due_date.data
        db.session.commit()
        return redirect(url_for('inquiry'))
    return render_template('edit_task.html', form=form, task=task)

@app.route('/delete/<int:task_id>', methods=['POST'])
def delete_task(task_id):
    task = Task.query.get_or_404(task_id)
    db.session.delete(task)
    db.session.commit()
    return redirect(url_for('inquiry'))


# 데이터프레임으로 CSV 파일 로드
df = pd.read_csv(csv_file, encoding='utf-8')
# GeoJSON 파일 로드
with open(geojson_file, encoding='utf-8') as f:
    geojson_data = json.load(f)

@app.route('/ttt')
def ttt():
    return render_template('ttt.html')

#  지도, 인구수 데이터 불러오기
@app.route('/geojson')
def get_geojson():
    return jsonify(geojson_data)

@app.route('/population')
def get_population():
    return jsonify(df.to_dict(orient='records'))

# 서점 데이터 불러오기
with open('static/book_store.json', 'r', encoding='utf-8') as f:
    book_store_data = json.load(f)

@app.route('/bookstoredata')
def bookstore_data():
    return jsonify(book_store_data)




if __name__ == '__main__':
    app.run(debug=True)
    