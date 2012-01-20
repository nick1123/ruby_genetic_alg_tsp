# Overview

This is a ruby program that uses a genetic algorithm to find an approximate solution to the TSP (traveling salesman problem) http://en.wikipedia.org/wiki/Travelling_salesman_problem

In the program cities are represented with a single char from
    ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789

It's not as pretty as some but its functional.

# Classes overview

* FullyConnectedMap - Hash of hashes that stores the distance between cities i.e. A => {B => 10, C => 35}, B => {A => 10, C => 17}, C => {A => 25, B => 17}
* Solution - Contains a potential solution to the TSP i.e. for a problem with 5 (ABCDE) cities a potential solution might be BDACE.  Each solution computes a total distance based the ordering of its cities and the distances in the fully\_connected\_map
* Scenario - Stores a collection of solutions, finds the best ones (shortest distance), mutates and crosses the best ones, etc.

# Run the dang thing

Checkout the options

    ruby driver.rb -h
	Options:
	   --divergence-min, -d <f>:   Level of divergence needed to stop (default: 0.01)
	     --cities-count, -c <i>:   How many cities are we solving for? (5 - 62) (default: 62)
	  --solutions-count, -s <i>:   How many solutions are in a population? Must be an integer >= 8 && divisible by 4 (default: 40)
	   --iterations-min, -i <i>:   How many iterations before we can possibly stop (if divergence is low enough) (default: 1000)
	   --iterations-max, -t <i>:   After this many iterations we stop looking for better solutions (default: 5000)
	                 --help, -h:   Show this message


Run with default params

    ruby driver.rb

Run a few tests

    rspec tests/test_spec.rb

# Example Output

	Best Solutions (Top 10 out of population of 40)
	Solution: MbNIJfupWX510jYys8DH4EFavRVe2Gxkc7UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2681963  Random  LifeSpan: 1
	Solution: fehQBpZX3RUEHjvzcGuCiD7nqNg6sJkV0AodmlPI4My5axwbKOYrTtW8LF129S  Distance: 2811430  Random  LifeSpan: 1
	Solution: FLvG7zd4kqegHCDZ6ocP2TMSfij3EJlbrVK0ta8R5WNwIYhXupAyn91UBxOsmQ  Distance: 2820698  Random  LifeSpan: 1
	Solution: eMaC5uArHEPpw7D4ZIq3oh9zdgSW2lJmsnOjGb8vF1fRicyNtQ0xVKT6kBXLUY  Distance: 2847843  Random  LifeSpan: 1
	Solution: eFagnVtCJfOhij76MKk93L1Wq4zNIBTS2oU5uZDXlQPRxwAcdypbmvsEHr08YG  Distance: 2912856  Random  LifeSpan: 1
	Solution: yWzNAGwfJt6ZUXIKYDVTSbHqkP2Cdj8vFaxrogcML53p4BesRO7l1QE0mu9nhi  Distance: 2929499  Random  LifeSpan: 1
	Solution: IzTMqVPxKdrXscpbYlfE1NWU96aBuSCnkAtgj7HJRvLiGe480Domy2OwZF3Q5h  Distance: 2968740  Random  LifeSpan: 1
	Solution: oUsaApi2qvlxwTh5PERKrQbde3m1CGMkDuO60YXgZtVJ9W7ycn8j4ISHzLfNBF  Distance: 2970500  Random  LifeSpan: 1
	Solution: TGmL0onDE4e6JMpbkXqKCcHAsNSlvi7Qf29PaVwRjWBIdr3z1hOg8yFUZYu5xt  Distance: 2996160  Random  LifeSpan: 1
	Solution: RSqzOMsnYKukcNEbQL4rxIPy0fdvJGBZ5j8UieH1l7moAg62DCVXt93WahTwFp  Distance: 2996566  Random  LifeSpan: 1
	Iteration: 1 (Min: 1000)    Divergence: 0.117303258844361 (Min: 0.01)

	Best Solutions (Top 10 out of population of 40)
	Solution: fehQnVtC3RUEij76cGuDqNzsJk0AodZXlPaxKOYrmvW8H9SBpgI4My5wbTLF12  Distance: 2511814  Hybrid  LifeSpan: 1
	Solution: MbNIJfupWX510jYys8DH4EFavRVecGxk27UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2651740  Mutant  LifeSpan: 1
	Solution: MbNIJfupWX510jYys8DH4EFavRVe2Gxkc7UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2681963  Random  LifeSpan: 2
	Solution: fehQBpZX3RUEHjvzcGuCiDtnqNg6sJkV0AodmlPI4My5axwbKOYrT7W8LF129S  Distance: 2715785  Mutant  LifeSpan: 1
	Solution: eFagnVtC3RUEHjvzcGk9iD1WqN6sJTS0A5mlXQPxwbdyYr8L2fOh7MK4IBouZp  Distance: 2758635  Hybrid  LifeSpan: 1
	Solution: wKHdnyN2e5PQRh0X1AzJWmqoUjkMFf4lTuVL8rc6apZ7ixCvGgBYOItbDS9sE3  Distance: 2772459  Random  LifeSpan: 1
	Solution: FLvG7zd4kqegHCDZ6oNP2TMSfij3EJlbrVK0ta8R5WcwIYhXupAyn91UBxOsmQ  Distance: 2805394  Mutant  LifeSpan: 1
	Solution: fehQBpZX3RUEHjvzcGuCiD7nqNg6sJkV0AodmlPI4My5axwbKOYrTtW8LF129S  Distance: 2811430  Random  LifeSpan: 2
	Solution: eMaC5uArHEPpw7D4ZIq3oh9zdgSW2lJmsnOjGb1vF8fRicyNtQ0xVKT6kBXLUY  Distance: 2815387  Mutant  LifeSpan: 1
	Solution: FLvG7zd4kqegHCDZ6ocP2TMSfij3EJlbrVK0ta8R5WNwIYhXupAyn91UBxOsmQ  Distance: 2820698  Random  LifeSpan: 2
	Iteration: 2 (Min: 1000)    Divergence: 0.12297248124264 (Min: 0.01)

	Best Solutions (Top 10 out of population of 40)
	Solution: fehQnVtC3RUEij76cGuDqNzsJk0AodZXlPaxKOYrmvW8H9SBpgI4My5wbTLF12  Distance: 2511814  Hybrid  LifeSpan: 2
	Solution: MbhQJfup3RUEij76s8D4zk0AodZXcaxKOlqB9WCSgtrywLF12enVGNPYmvHI5T  Distance: 2567403  Hybrid  LifeSpan: 1
	Solution: fehQnVtC3RUEij76cGuDqNzsJk0AodZXlPaxKOYrmvW8H9SBpgITMy5wb4LF12  Distance: 2639659  Mutant  LifeSpan: 1
	Solution: MbNIJfupWX510jYys8DH4EFavRVecGxk27UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2651740  Mutant  LifeSpan: 2
	Solution: wKHdBpN2e5PQRhvz1AuCiDqoUjkMFf4l0mc6aZ7xbGgYrOIW8S9X3EnsJVyTtL  Distance: 2661658  Hybrid  LifeSpan: 1
	Solution: MbNIJfupWX510jYys8DH4EFavRVe2Gxkc7UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2681963  Random  LifeSpan: 3
	Solution: MbNIJfupWX510jYys8DH4EFavRVe2G3kc7UP6dlqB9OQCSgoAxtrTKZzwinhmL  Distance: 2694477  Mutant  LifeSpan: 1
	Solution: oSqtjis6x3ZlkzvXuFUnmHOBcwL02EV1MhA4NC7dGY9TD8aRJpWPgeI5brQyfK  Distance: 2705495  Random  LifeSpan: 1
	Solution: enagFVtC3RUEHjvzcGk9iD1WqN6sJTS0A5mlXQPxwbdyYr8L2fOh7MK4IBouZp  Distance: 2705635  Mutant  LifeSpan: 1
	Solution: MbNsJfupWX510jYyI8DH4EFavRVecGxk27UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2715172  Mutant  LifeSpan: 1
	Iteration: 3 (Min: 1000)    Divergence: 0.0809606125294309 (Min: 0.01)

	Best Solutions (Top 10 out of population of 40)
	Solution: fehQnVtC3RUEij76cGYDqNzsJk0AodZXlPaxKOurmvW8H9SBpgI4My5wbTLF12  Distance: 2481048  Mutant  LifeSpan: 1
	Solution: fehQnVtC3RUEij76cGuDqNzsJk0AodZXlPaxKOYrmvW8H9SBpgI4My5wbTLF12  Distance: 2511814  Hybrid  LifeSpan: 3
	Solution: enNsJfupWX510jYyI8DHiFavRVcGxk27mlQPwbdrgoA3tMZzh4EU6qB9OCSTKL  Distance: 2528148  Hybrid  LifeSpan: 1
	Solution: MbhQJfup3RUEij76s8D4zk0AodZXcaxKOlqB9WCSgtrywLF12enVGNPYmvHI5T  Distance: 2567403  Hybrid  LifeSpan: 2
	Solution: MbhQJfup3RUEij76s8D4zk0AodZcXaxKOlqB9WCSgtrywLF12enVGNPYmvHI5T  Distance: 2600087  Mutant  LifeSpan: 1
	Solution: feqtjis63RZlkz7cGUnNw0AodXPaxCYr9TD8SBJpIMy5bQ12vuFmHOLEVh4WgK  Distance: 2606898  Hybrid  LifeSpan: 1
	Solution: wKHZBpN2e5PQRhvz1AuCiDqoUjkMFf4l0mc6ad7xbGgYrOIW8S9X3EnsJVyTtL  Distance: 2638396  Mutant  LifeSpan: 1
	Solution: fehQnVtC3RUEij76cGuDqNzsJk0AodZXlPaxKOYrmvW8H9SBpgITMy5wb4LF12  Distance: 2639659  Mutant  LifeSpan: 2
	Solution: MbNIJfupWX510jYys8DH4EFavRVecGxk27UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2651740  Mutant  LifeSpan: 3
	Solution: wKHdBpN2e5PQRhvz1AuCiDqoUjkMFf4l0mc6aZ7xbGgYrOIW8S9X3EnsJVyTtL  Distance: 2661658  Hybrid  LifeSpan: 2
	Iteration: 4 (Min: 1000)    Divergence: 0.0727958507856357 (Min: 0.01)

	Best Solutions (Top 10 out of population of 40)
	Solution: fehQnVtCWXUEij76cGDH4FavR0AodZ2xKOYrm9SBpgMyzbT1NIJu5s8kPlq3wL  Distance: 2295872  Hybrid  LifeSpan: 1
	Solution: MbhQnVtC3RUEij76cGD4zk0AodZXaOlqBKYrgywLF12eINPmvHJfups8x9WS5T  Distance: 2357520  Hybrid  LifeSpan: 1
	Solution: fehQnVtC3RUEij76cGYDqNzsJk0AodZXlPaxKOurmvW8H9SBpgI4My5wbTLF12  Distance: 2481048  Mutant  LifeSpan: 2
	Solution: enNsJfup3R510j76I8DHqavVAxkZXmlQPwbdrgo9SBh4EUMyLFKWYicG2tzOCT  Distance: 2488209  Hybrid  LifeSpan: 1
	Solution: fehQnVtC3RUEij76cGuDqNzsJk0AodZXlPaxKOYrmvW8H9SBpgI4My5wbTLF12  Distance: 2511814  Hybrid  LifeSpan: 4
	Solution: enNsJfupWX510jYyI8DHiFavRVcGxk27mlQPwbdrgoA3tMZzh4EU6qB9OCSTKL  Distance: 2528148  Hybrid  LifeSpan: 2
	Solution: MbNIJfupWX510j8ysYDH4EFavRVecGxk27UP6dlqB9OQCSgoA3trTKZzwinhmL  Distance: 2541990  Mutant  LifeSpan: 1
	Solution: enNsJfupWX51tjYyI8DHiFavRVcGxk27mlQPwbdrgoA30MZzh4EU6qB9OCSTKL  Distance: 2543991  Mutant  LifeSpan: 1
	Solution: wKHZBpN2e5PQRhyz1AuCiDqoUjkMFf4l0mc6ad7xbGgYrOIW8S9X3EnsJVvTtL  Distance: 2565460  Mutant  LifeSpan: 1
	Solution: MbhQJfup3RUEij76s8D4zk0AodZXcaxKOlqB9WCSgtrywLF12enVGNPYmvHI5T  Distance: 2567403  Hybrid  LifeSpan: 3
	Iteration: 5 (Min: 1000)    Divergence: 0.118269224068241 (Min: 0.01)

