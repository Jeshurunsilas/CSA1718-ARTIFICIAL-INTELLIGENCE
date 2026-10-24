
% Roads and distances
road(a, b, 4).
road(a, c, 1).
road(a, e, 3).
road(b, d, 5).
road(b, e, 2).
road(c, d, 3).
road(c, e, 2).
road(d, e, 1).

% Undirected roads
distance(X, Y, D) :- road(X, Y, D).
distance(X, Y, D) :- road(Y, X, D).

% Calculate the total distance of a tour
tour_distance([_], 0).
tour_distance([X, Y | Rest], Total) :-
    distance(X, Y, D),
    tour_distance([Y | Rest], Remaining),
    Total is D + Remaining.

% DFS: find tours visiting all cities exactly once
tsp(Start, BestTour, BestDistance) :-
    findall(City, (
        road(X, City, _),
        (X = a ; road(City, X, _))
    ), _),
    findall(Tour-Distance, (
        permutation([b, c, d, e], Remaining),
        Tour = [Start | Remaining],
        append(Tour, [Start], CompleteTour),
        tour_distance(CompleteTour, Distance)
    ), Tours),
    sort(2, @=<, Tours, [BestTourDistance | _]),
    BestTourDistance = BestTour-BestDistance.
