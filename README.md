# 375Nim
An easy console based interactive nim game for piles [3, 7, 5].

## Usage
Run the ruby script and play. The first player is determined by fortune. The computer will win when it can. 

## Proof
In case proof that the first player of this game has a winning strategy is needed, it will be provided as below. 

Let us define a function F, that takes any possible state of the game in progress and returns a characteristic value that describes the state. Let F(S) be the XOR for number of stones in each pile of state S, e.g., the characteristic value of the initial state is F([3, 7, 5]) = 3 XOR 7 XOR 5 = 1. 

We claim that for any state S, iff f(S) is nonzero, there is a winning strategy. 

The losing state (that must be traveled in the end of any game) is [0, 0, 0], where F([0, 0, 0]) = 0. We can show that, for any state S that F(S) is nonzero, there is always a way to take some positive number of stones from a pile, such that the resulting state S' always has F(S') = 0. And, for any state S that F(S) is 0, there is no valid move to result in a state S' such that F(S') is 0. This is essential because it implies that at any state S such that F(S) is nonzero, there is always a sequence of valid moves that could always help the first player retain a nonzero characteristic value when he is to move, i.e., he will never be in state [0, 0, 0] since F([0, 0, 0]) = 0. 

For any S such that F(S) is nonzero, there is always a way (valid move) to result to S' such that F(S') = 0. It can be constructed as follows. Let x = F(S), m = max(S). If the most significant bit of x is the same with the most significant bit of m, i.e., MSB(x) = MSB(m); MSB(t) = k, k is maximum integer s.t. 2^k divides t, then we can always make the pile with m stones into a pile with x XOR m stones, since x XOR m must be less than m, and the new characteristic value will be F(S) XOR x = x XOR x = 0. Otherwise this bit does not contribute to the chracteristic value, thus we will reduce MSB(m) from every value v in S s.t. v >= MSB(m), until the maximum value in the modified set S has MSB equal to MSB(x), and apply the version above (this is always possible unless F(S) is zero). 

However, for any S such that F(S) = 0, since the player must make a move, and for any chosen pile with x stones, the possible new number of stones is in [0, x - 1]. Hence the possible characteristic values is in set { F(S) XOR x XOR i, i in [0, x - 1] }, in which obviously none would be 0. 
