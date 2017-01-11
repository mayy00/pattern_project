
y = [0.033582,0.079104, 0.18284, 0.36716, 0.71269, 0.89552, 0.95672];
x = [5,10,20,30,40,50,60];

figure, plot(x,y, '-bo','MarkerFaceColor',[0 0 1]);
xlabel('Number of Visual Words', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Accuracies','FontSize', 14, 'FontWeight', 'bold');
