# 📖 Reader Mind Project
## About
- 출판사나 지역 서점을 위한 신간 도서 추천 프로그램
## Purpose
- 기존에 출판되었던 월간 베스트셀러 도서들의 선호도를 분석해 최신 독서 트렌드를 파악
- 데이터 분석을 통해 인사이트를 제공하여 출판사 • 지역서점의 판매전략 수립에 도움을 주기 위함.
  - 출판사는 어떤 유형의 도서를 출판하면 좋을지
  - 지역 서점은 어떤 고객층을 특정하고 해당 고객층을 대상으로 어떤 유형의 도서들을 구비하는게 좋을지
- 나아가 이러한 솔루션들을 통해 점점 감소하고 있는 사람들의 독서량을 증진시키기 위함.

## Getting Started
To set up and run the Reader Mind Project, follow these steps:

1. **Create a Folder:**
   - In your VSCode workspace, create a new folder with a name of your choice (e.g., `Reader_Mind`).

2. **Download Files:**
   - Download all files and save them into the folder you just created.

3. **Open VSCode:**
   - Open the folder in VSCode.

4. **Navigate to the Folder:**
   - Open the command line terminal within VSCode and navigate to your project directory using the following command:
     ```
     cd your_folder_name
     ```
     Replace `your_folder_name` with the name of the folder you created (e.g., `Reader_Mind`).

5. **Generate a Secret Key:**
   - Run the `generate_secret_key.py` file to create a secret key for protection against CSRF attacks. Use the command:
     ```
     python generate_secret_key.py
     ```
   - Copy the generated secret key from the terminal output.

6. **Update Configuration:**
   - Open the `config.py` file and paste the copied secret key into the designated key input section.

7. **Run the Application:**
   - Execute the application by running:
     ```
     python app.py
     ```
   - After running the command, you will see a URL in the terminal output (e.g., `https://127.0.0.1:(portnum)`). Click on this URL to access the web application.

Enjoy exploring our simple yet informative web application! If you have any questions or run into issues, feel free to ask for help.
