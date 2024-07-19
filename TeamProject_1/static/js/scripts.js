document.addEventListener("DOMContentLoaded", function () {
    // Handle menu box click events
    const menuBoxes = document.querySelectorAll(".menu-box");
    const optionsContainers = document.querySelectorAll(".options-container");

    menuBoxes.forEach(function (menuBox) {
        menuBox.addEventListener("click", function () {
            const targetId = menuBox.getAttribute("data-target");
            if (!targetId) return;

            const optionsContainer = document.getElementById(targetId);
            if (optionsContainer) {
              optionsContainers.forEach(function (container) {
                if (container.id !== targetId) {
                    container.style.display = "none";
                }
              });
              const isVisible = optionsContainer.style.display === "block";
              optionsContainer.style.display = isVisible ? "none" : "block";
            }
        });
    });

    // Handle option select events
    const ageSelect = document.getElementById("age-select");
    const catSelect = document.getElementById("cat-select");
    const sexSelect = document.getElementById("sex-select");
    const resultContainer = document.getElementById("resultContainer");
    const backButton = document.getElementById("backButton");
    const submitBtn = document.getElementById("submitBtn");
    const alertBox = document.querySelector(".alert");

      
    ageSelect.addEventListener("change", function () {
        const selectedAge = ageSelect.value;
        showResult(`연령대 선택: ${selectedAge}`);
      });

    catSelect.addEventListener("change", function () {
        const selectedCategory = catSelect.value;
        showResult(`카테고리 선택: ${selectedCategory}`);
    });

    sexSelect.addEventListener("change", function () {
        const selectedSex = sexSelect.value;
        showResult(`성별 선택: ${selectedSex}`);
    });

    // Function to display result
    function showResult(resultText) {
        resultContainer.style.display = "block";
        document.getElementById("result").innerHTML = resultText;
    }

    // submit button - publisher_servidce
    submitBtn.addEventListener("click", function () {
        alertBox.style.display = "block";
        resultContainer.style.display = "none";
    })

    // Back button - 
    backButton.addEventListener("click", function () {
        resultContainer.style.display = "none";
    });


    // Function to toggle options container
    function toggleOptions(container) {
      const isVisible = container.style.display === "block";
      container.style.display = isVisible ? "none" : "block";
  }
});


// publisher_service 부분
document.addEventListener("DOMContentLoaded", function () {
  const submitBtn = document.getElementById("submitBtn");
  const modal = document.getElementById("myModal");
  const span = document.getElementsByClassName("close")[0];

  submitBtn.addEventListener("click", function () {
      modal.style.display = "block"; // 모달을 보이도록 설정
  });

  span.addEventListener("click", function () {
      modal.style.display = "none"; // 모달을 숨기도록 설정
  });

  window.addEventListener("click", function (event) {
      if (event.target === modal) {
          modal.style.display = "none"; // 모달 외부 클릭 시 모달을 숨기도록 설정
      }
  });
});


document.getElementById('submitBtn').addEventListener('click', function() {
  generateInsights();
});
