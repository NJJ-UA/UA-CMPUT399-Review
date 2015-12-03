# Review of CMPUT 399 (Visual Recognition)
**Sample Questions for the Final Examination**

*Author: Zhaorui Chen (zhaorui at ualberta dot ca)*

-----------------------------------------------------

**Lecture Module: Introduction to visual recognition**

Q1: Name some of the challenges in visual recognition.

    Answer here.
    
Q2: Mention five commercially successful applications of visual recognition.
    
    Answer here.

Q3: Arrange these visual recognition tasks according their degree of difficulty starting from the easiest to the hardest.
    
    Answer here.
    
-----------------------------------------------------

**Lecture Module: Introduction to images**

Convolution: Apply filters to the image/blurring image

Q1: Explain the role of scale in edge detection.
    
    Edges can only be detected at a scale.

Q2: Name two edge detection operators.
    
    http://www.ics.uci.edu/~majumder/DIP/classes/EdgeDetect.pdf
    sobel, prewitt operator

Q3: Canny edge detection method has four sequential steps. What are they? Explain each step in one/two sentences.
    
    Step 1: Noise Reduction, smoothing
    Smooth image with Gaussian filtering.
    Step 2: Gradient Computation
    Find out edge strength and orientation of the smoothed image.
    Step 3 (non-maximum suppression): At each pixel, determine if it has maximum edge strength along the edge orientation. Mark such pixels as edge pixels.
    Step 4 (hysteresis Thresholding)
    Apply a high threshold to the edge strength magnitude to detect a set of edges.
    Follow the edges perpendicular to the edge orientation. If the pixels survive a low threshold, keep it as an edge pixel

Q4: What is the role of Gaussian smoothing in edge detection?
    
    It is used to smooth the image by filtering in step1.  
    Handling with the borders:
    zero padding/clip filter/留白: set to constant value imfilter(f, g, 0)
    Copy edge/ replication/Take the value of the closet border pixel/延伸边界像素: imfilter(f, g, ‘replicate’)
    Wrap around: imfilter(f, g, ‘circular’)
    Reflected across the edge: imfilter(f, g, ‘sysmetric’)

Q5: You will be a 5-by-5 grayscale image patch. Apply Prewitt edge operator ([-1 0 1; -1 0 1; -1 0 1], [-1 -1 -1; 0 0 0; 1 1 1]) on this image patch and write the results. Extend image orders by zero padding. 
    
    Answer here.
    
Q6: Given a 5-by-5 grayscale image patch, compute a 3-by-3 averaging filter. Extend the image boundaries by replication (extend by closest border pixel).
    
    Answer here.

Q7: Is Laplace filter a smoothing filter or a difference filter.
    
    No.
    Smoothing: mean(box), Gaussian, median (For blurring, noise-deduction, segmentation)
    Difference: Laplace (for de-blurring, edge detection)

Q8: Are linear filters commutative and associative? Explain your answer with a small example.
    
    Yes. Convolution is commutative and associative.
    See http://cs.nyu.edu/~fergus/teaching/vision/3_filtering.pdf
    https://eclass.srv.ualberta.ca/pluginfile.php/2328092/mod_resource/content/1/Filters.pdf

Q9: Given a 5-by-5 grayscale image patch, compute 3-by-3 median filter on it.
    
    Answer here.

Q10: Is median filter non-linear?
    
    Yes.
    Non-linear filter: does not maintain linearity,不遵循linear filter的运算规律

Q11: To remove ‘salt-and-pepper’ type noise, which filter would you choose between these two: Gaussian smoothing and median?
    
    Median.
    Reason: ‘median’ is less sensitive than linear techniques to extreme changes in pixel values, it can remove salt and pepper noise without significantly reducing the sharpness of an image.

Q12: Can two different grayscale images have the same histogram?
    
    Yes
    Normalized histogram
    See https://eclass.srv.ualberta.ca/pluginfile.php/2328094/mod_resource/content/1/Histograms.pdf

Q13: What information is lost going from a grayscale image to its histogram?
    
    Anwser here.

Q14: Mention two metrics for matching two histograms.
    
    Kullback-Liebler divergence
    Bhattacharya coefficient
    Diffusion Distance

Q15: Given two histograms, you will be asked to compute Bhattacharya coefficient between them.
    
    BC = 1 ----> perfectly match
    BC < 1 ----> more = better match 
    
Q16: What are the maximum and the minimum values of a Bhattacharya coefficient?
    
    Max: 1 
    Min: 0
    
Q17: A joint histogram is a two dimensional array or a one dimensional array?
    
    2-dimensional array
    Each entry in the joint histogram contains the number of pixels in an image that are described by a k-tuple of feature values

-----------------------------------------------------

**Lecture Module: Basic machine learning**

Q1: What is the parameter in a k-nearest neighbor (knn) method that you learn during training? Explain in a few sentences how you learned this parameter in assignment 1 on people counting?
    
    Parameter k.  Using k-fold cross validation
    For example, in 5-fold cross-validation, we would split the training data into 5 equal folds, use 4 of them for training, and 1 for validation. We would then iterate over which fold is the validation fold, evaluate the performance, and finally average the performance across the different folds. Take the k with the highest average.

Q2: Name an efficient implementation technique for the knn method.
    
    Build a kdTree and query in the tree.

Q3: What is in your opinion the biggest disadvantage of the knn method? Any advantage in your opinion?
    
    Advantages
    very simple to implement and understand
    Drawbacks
    1. The classifier must remember all of the training data and store it for future comparisons with the test data. This is space inefficient because datasets may easily be gigabytes in size.
    2. Classifying a test image is expensive since it requires a comparison to all training images.
    3. Not work well in high dimensions

Q4: What feature did you use in the knn method in assignment 1 on people counting? Name another feature that you could have used in this assignment.
grayscale histogram within a region of interest
    
    Answer here.

Q5: Explain K-fold cross validation method in a few sentences. Why do we need cross validation while training a machine learner? 
    
    Answer here.

Q6: Explain briefly how the computational complexity would vary for a K-fold cross validation, if the number of parameters to be learned increases from one to two.
    
    Answer here.

-----------------------------------------------------

**Lecture Module: Local feature**

Q1: Explain in a sentence or two, why Harris corner detector is not scale invariant.
    
    When scale changes and image is zoomed in, all corner points will be classified as edges. 

Q2: Explain why Harris corner detector is rotation invariant?
    
    https://courses.cs.washington.edu/courses/cse455/09wi/Lects/lect6.pdf
    Page 27 for steps in Harris detector
    Because M = X[lamda1, 0; 0, lamda2]X’, cornerness score remains unchanged.
    Eigenvalues remains the same, which is the local maxima

Q3: How scale invariant feature points are detected in SIFT? Explain briefly.
    
    It searches for interest points in different scale spaces, and compute the domain orientation of its neighborhood.
    Interest points are local maxima in both position and scale.

Q4: Why a SIFT feature vector is scale and rotation invariant? Explain briefly.
    
    SIFT will find the best scale to represent each feature.
    Scale invariant: SIFT uses the DOG to extract the features from scale space. If the feature is repeatably present in between Difference of Gaussians, then it is Scale-Invariant and we should keep it.
    Rotation invariant: Rotate all features to go the same way in a determined manner/ Take histogram of Gradient directions /Rotate to most dominant

Q3: What is the dimension of a SIFT feature vector?
    
    128

Q4: Why does SIFT (both the interest points and the feature vectors) have some illumination invariance? Explain briefly. 照明不变性
    
    SIFT在生成描述子阶段，进行了归一化处理，从而消除了光照变化的影响

-----------------------------------------------------

**Lecture Module: Matching local features**

Q1: What is a visual word?
    
    Answer here.

Q2: Imagine you are building an image retrieval system. Your image database consists of 100K images. Explain all the steps of building a SIFT-based indexing system for this image database toward image retrieval.
    
    Answer here.
    
Q3: If you have N SIFT vectors, what method do you use for vector quantizing these vectors into M visual words (M<=N)?
    
    K-means algorithm

-----------------------------------------------------

**Lecture Module: Geomertic verification of matching**

Q1: What is the goal of geometric verification?
    
    Anwser here.

Q2: Suppose you have N putative matches between two images. You are required to do geometric verification using an affine transformation model using RANSAC. Outline the steps of this geometric verification algorithm.
    
    Anwser here.
    
Q3: You are given N two dimensional points. Outline the steps of fitting a straight line through these points using RANSAC algorithm. (Correctly) Assume any input parameters the algorithm needs.
    
    Anwser here.
    
Q4: At least how many pairs of matching points do you need to compute affine transform parameters?
    
    10 https://courses.cs.washington.edu/courses/cse576/.../ch11.pdf
    
Q5: At least how many pairs of matching points do you need to compute homography?
    
    4 http://vision.gel.ulaval.ca/~jflalonde/cours/4105/h14/tps/results/tp4/jingweicao/index.html

-----------------------------------------------------

**Lecture Module: Support vector machine**

Q1: Solve this optimization problem graphically: minx f(x)=x2, subject to x>=2. For solving a problem graphically you need to (approximately) plot the function and then find out the solution with eye-balling.
    
    Anwser here.
    
Q2: Solve the same optimization problem, by forming a Lagrangian, dual and maximizing the dual.
    
    Anwser here.
    
Q3: Suppose, after training a linear SVM, you obtained the slope of the hyperplane classifier as w (a n-length vector) and intercept as b (a scalar). For a feature vector x (a n-length vector), how would you compute the score that the trained SVM assigns to this feature vector?
    
    Anwser here.
    
Q4: Between a knn and a linear SVM, which one do you think would be faster? Why?
    
    Anwser here.
    
Q5: Between a knn and a linear SVM, which one requires more memory during testing?
    
    Anwser here.
    
-----------------------------------------------------

**Lecture Module: Image classification**

Q1: Explain briefly the steps of computing VLAD encoding.
    
    Anwser here.
    
Q2: Explain briefly the steps of computing FV encoding.
    
    Anwser here.
    
-----------------------------------------------------
    
**Lecture Module: Object localization**

Q1: Explain briefly how a cascaded classifiers work.
    
    Anwser here.
    
Q2: Computation of integral image on a small grayscale image patch.
    
    Anwser here.
    
Q3: Spend only 2/3 sentences to explain how an integral image helps in real-time face detection.
    
    Anwser here.
    
Q4: How would you try to overcome the computational bottleneck in a sliding window technique for object detection?
    
    Anwser here.
    
Q5: What is the advantage of working with raw image patches as features in object detection? Mention one disadvantage as well.
    
    Anwser here.
    
-----------------------------------------------------    

**Lecture Module: CVPR 2014 deep learning tutorial**

Q1: What are the differences between a deep CNN and a linear SVM?
    
    Anwser here.

Q2: Why does a deep CNN require a way more training samples than its counterpart a linear SVM for the same learning task?
    
    Anwser here.
    
Q3: Why does training a deep CNN is a lot harder than training a SVM?
    
    Anwser here.
    
Q4: Does the optimization used in deep CNN a convex optimization?
    
    Anwser here.
    
Q5: Explain briefly how a deep CNN be used for object localization.
    
    Anwser here.
    
Q6: Given an example of a non-linear function used in a deep CNN.
    
    Anwser here.
    
Q7: What does spatial pooling achieve in a deep CNN architecture?
    
    Anwser here.
    
-----------------------------------------------------

**Lecture Module: ICCV 2013 tutorial on part-based models for recognition**

Q1: Why does a part-based model do better than a HoG-based global object detector? Explain briefly.
    
    Anwser here.

-----------------------------------------------------

Filters:

Convolution, (线性filter,非线性filter)
SIFT, K-means, BoG步骤, inverted index!!!
RANSAC
