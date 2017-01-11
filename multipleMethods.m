function  [trainAcc, trainClassBased, testAcc, testClassBased] = multipleMethods(trainXNorm, testXNorm, train_labels, test_labels, option)

if option == 1
    t = templateSVM('KernelFunction', 'linear');
    learn = fitcecoc(trainXNorm, train_labels, 'Learners', t);
    %for training accuracy
    predict_labels_train = predict(learn, trainXNorm);
    trainClassBased = class_based(predict_labels_train, train_labels);
    trainAcc = sum(predict_labels_train' == train_labels) / size(train_labels,2);
    
    %for test accuracy
    predict_labels_test = predict(learn, testXNorm);
    testClassBased = class_based(predict_labels_test, test_labels);
    testAcc = sum(predict_labels_test' == test_labels) / size(test_labels,2);
    
elseif option == 2
    knnModel = fitcknn(trainXNorm,train_labels);
    
    %for training accuracy
    predict_labels_train = predict(knnModel, trainXNorm);
    trainClassBased = class_based(predict_labels_train, train_labels);
    trainAcc = sum(predict_labels_train' == train_labels) / size(train_labels,2);
    
    %for test accuracy
    predict_labels_test = predict(knnModel, testXNorm);
    testClassBased = class_based(predict_labels_test, test_labels);
    testAcc = sum(predict_labels_test' == test_labels) / size(test_labels,2);

elseif option == 3
    nbModel = fitcnb(trainXNorm,train_labels);
   
    %for training accuracy
    predict_labels_train = predict(nbModel, trainXNorm);
    trainClassBased = class_based(predict_labels_train, train_labels);
    trainAcc = sum(predict_labels_train' == train_labels) / size(train_labels,2);
    
    %for test accuracy
    predict_labels_test = predict(nbModel, testXNorm);
    testClassBased = class_based(predict_labels_test, test_labels);
    testAcc = sum(predict_labels_test' == test_labels) / size(test_labels,2);

else
     t = templateSVM('KernelFunction', 'polynomial');
    learn = fitcecoc(trainXNorm, train_labels, 'Learners', t);
    %for training accuracy
    predict_labels_train = predict(learn, trainXNorm);
    trainClassBased = class_based(predict_labels_train, train_labels);
    trainAcc = sum(predict_labels_train' == train_labels) / size(train_labels,2);
    
    %for test accuracy
    predict_labels_test = predict(learn, testXNorm);
    testClassBased = class_based(predict_labels_test, test_labels);
    testAcc = sum(predict_labels_test' == test_labels) / size(test_labels,2);
end
end