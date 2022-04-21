double squared_difference(double x, double y) {
    return std::pow(x - y, 2);
}

double distance(double x1, double y1, double x2, double y2) {
    return std::sqrt(squared_difference(x1, x2) + squared_difference(y1, y2));
}

if (y == 0) {
    for (double y_it = y - epsilon; y_it < y + epsilon; y_it += epsilon / 20) {
        if (distance(...)) ...
    }
}

class Point {
public: 
    Point(double x, double y) : x_(x), y_(y) {}
    
public:
    double distanceTo(const Point& point) const {
        return distance(x_, y_, point.x_, point.y_);
    }
    
private:
    double x_ = 0, y_ = 0;
}

Point p1(0, 0);
Point p2(-1, 1);

p1.distanceTo(p2);

# python
A = ... # function
B = ... # function
compose = lambda F, G: lambda x: F(G(x))
data = ...
result = map(compose(A, B), data)

# 
result = []
for x in data:
    b = B(x)
    a = A(b)
    result.append(a)
    
    
# prolog
mother(sam, lucy).
mother(lucy, pamela).
father(sam, john).

parent(X, Y) :- mother(X, Y); father(X, Y).
grandfather(X, G) :- parent(X, P), father(P, G).
grandmother(X, G) :- ... 