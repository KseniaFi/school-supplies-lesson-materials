<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interactive Book</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f5f5f5;
            font-family: 'Georgia', serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            perspective: 1000px;
            overflow-x: hidden;
            padding: 20px;
        }

        .book-container {
            width: 90vw;
            height: 70vh;
            max-width: 800px;
            max-height: 600px;
            position: relative;
            transform-style: preserve-3d;
        }

        .book {
            width: 100%;
            height: 100%;
            position: relative;
            transform-style: preserve-3d;
            transition: transform 0.6s;
        }

        .page {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            transform-origin: left center;
            transform-style: preserve-3d;
            transition: transform 0.8s ease-in-out;
            border-radius: 5px;
            overflow: hidden;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        .front, .back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .back {
            transform: rotateY(180deg);
        }

        .page-image {
            width: 100%;
            height: 100%;
            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .page-image.loaded {
            opacity: 1;
        }

        /* Page positioning */
        .page[data-page="cover"] { z-index: 10; }
        .page[data-page="1"] { z-index: 9; }
        .page[data-page="2"] { z-index: 8; }
        .page[data-page="3"] { z-index: 7; }
        .page[data-page="4"] { z-index: 6; }
        .page[data-page="5"] { z-index: 5; }
        .page[data-page="6"] { z-index: 4; }
        .page[data-page="7"] { z-index: 3; }
        .page[data-page="8"] { z-index: 2; }
        .page[data-page="9"] { z-index: 1; }

        /* Flipped page state */
        .flipped {
            transform: rotateY(-180deg);
        }

        /* Navigation buttons */
        .navigation {
            position: absolute;
            bottom: -60px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 20px;
            z-index: 100;
        }

        .nav-btn {
            padding: 10px 25px;
            background-color: #8a2be2; /* Purple color */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
            font-family: 'Georgia', serif;
        }

        .nav-btn:hover {
            background-color: #6a1cb0; /* Darker purple on hover */
        }

        .nav-btn:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        /* Loading indicator */
        .loading {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 20px;
            color: #8a2be2;
            z-index: 1000;
        }

        /* Mobile adaptation */
        @media (max-width: 768px) {
            .book-container {
                width: 95vw;
                height: 80vh;
            }
            
            body {
                perspective: 500px;
            }
        }

        @media (max-width: 480px) {
            .book-container {
                width: 98vw;
                height: 85vh;
            }
            
            .nav-btn {
                padding: 8px 16px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="loading">Loading book...</div>
    
    <div class="book-container" style="display: none;">
        <div class="book">
            <!-- Cover -->
            <div class="page" data-page="cover">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224535_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224342_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 1 -->
            <div class="page" data-page="1">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224342_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224350_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 2 -->
            <div class="page" data-page="2">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224350_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224357_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 3 -->
            <div class="page" data-page="3">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224357_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224404_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 4 -->
            <div class="page" data-page="4">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224404_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224446_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 5 -->
            <div class="page" data-page="5">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224446_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224453_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 6 -->
            <div class="page" data-page="6">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224453_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224457_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 7 -->
            <div class="page" data-page="7">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224457_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224514_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 8 -->
            <div class="page" data-page="8">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224514_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224519_Gallery.jpg"></div>
                </div>
            </div>
            
            <!-- Page 9 -->
            <div class="page" data-page="9">
                <div class="front">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224519_Gallery.jpg"></div>
                </div>
                <div class="back">
                    <div class="page-image" data-src="Photos/Screenshot_20250921_224523_Gallery.jpg"></div>
                </div>
            </div>
        </div>
        
        <!-- Navigation buttons -->
        <div class="navigation">
            <button id="prev-btn" class="nav-btn" disabled>Back</button>
            <button id="next-btn" class="nav-btn">Next</button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loadingElement = document.querySelector('.loading');
            const bookContainer = document.querySelector('.book-container');
            const pages = document.querySelectorAll('.page');
            const pageImages = document.querySelectorAll('.page-image');
            const prevBtn = document.getElementById('prev-btn');
            const nextBtn = document.getElementById('next-btn');
            let currentPage = 0;
            const totalPages = pages.length;
            
            // Function to preload images
            function preloadImages() {
                return new Promise((resolve, reject) => {
                    let loadedCount = 0;
                    const totalImages = pageImages.length;
                    
                    if (totalImages === 0) {
                        resolve();
                        return;
                    }
                    
                    pageImages.forEach(imgElement => {
                        const imgSrc = imgElement.getAttribute('data-src');
                        const img = new Image();
                        
                        img.onload = function() {
                            imgElement.style.backgroundImage = `url('${imgSrc}')`;
                            imgElement.classList.add('loaded');
                            loadedCount++;
                            
                            if (loadedCount === totalImages) {
                                resolve();
                            }
                        };
                        
                        img.onerror = function() {
                            console.error(`Failed to load image: ${imgSrc}`);
                            loadedCount++;
                            
                            if (loadedCount === totalImages) {
                                resolve();
                            }
                        };
                        
                        img.src = imgSrc;
                    });
                });
            }
            
            // Function to update button states
            function updateButtons() {
                prevBtn.disabled = currentPage === 0;
                nextBtn.disabled = currentPage === totalPages - 1;
            }
            
            // Function to flip to next page
            function flipNext() {
                if (currentPage < totalPages - 1) {
                    pages[currentPage].classList.add('flipped');
                    currentPage++;
                    updateButtons();
                }
            }
            
            // Function to flip to previous page
            function flipPrev() {
                if (currentPage > 0) {
                    currentPage--;
                    pages[currentPage].classList.remove('flipped');
                    updateButtons();
                }
            }
            
            // Initialize the book after images are loaded
            preloadImages().then(() => {
                // Hide loading indicator and show book
                loadingElement.style.display = 'none';
                bookContainer.style.display = 'block';
                
                // Add click handlers to each page (forward only)
                pages.forEach((page, index) => {
                    page.addEventListener('click', function() {
                        if (index === currentPage) {
                            flipNext();
                        }
                    });
                });
                
                // Button handlers
                prevBtn.addEventListener('click', flipPrev);
                nextBtn.addEventListener('click', flipNext);
                
                // Initialize button states
                updateButtons();
            }).catch(error => {
                console.error('Error loading images:', error);
                loadingElement.textContent = 'Error loading book. Please refresh the page.';
            });
        });
    </script>
</body>
</html>
