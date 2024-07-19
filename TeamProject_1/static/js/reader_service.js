document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('book-recommendation-form');
    const resultContainer = document.getElementById('recommendation-result');
  
    if (form) {
        form.addEventListener('submit', function(event) {
            event.preventDefault();
  
            const age = document.getElementById('age').value;
            const gender = document.getElementById('gender').value;
  
            fetch('/recommend', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({ age, gender })
            })
            .then(response => response.json())
            .then(data => {
                if (resultContainer) {
                    resultContainer.innerHTML = '';
                    if (data.recommendations) {
                        data.recommendations.forEach(book => {
                            const bookElement = document.createElement('div');
                            bookElement.textContent = book;
                            resultContainer.appendChild(bookElement);
                        });
                    } else {
                        resultContainer.textContent = '추천 도서를 찾을 수 없습니다.';
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                if (resultContainer) {
                    resultContainer.textContent = '오류가 발생했습니다. 다시 시도해 주세요.';
                }
            });
        });
    } else {
        console.error('Form element not found');
    }
});
