x = [-1000:.1:1000];
norm = normpdf(x,-80,10);

norm2 = normpdf(x,60,30);
hold on;
plot(x,norm)
plot(x,norm2, 'r')

y = 10.*randn(10,1) + -80
y1 = 30.*randn(10,1) + 60
scatter(y,zeros(1,10));
scatter(y1,zeros(1,10),'r');