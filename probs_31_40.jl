
function prob31(coins=[1,2,5,10,20,50,100,200], target=200)
    """
    Detects the number of ways to make the largest coin given any number of smaller coins.
    """
    ways = zeros(Int, target+1)
    ways[1] = 1

    for c in coins
        if c <= target
            for i = c:target
                ways[i+1] += ways[(i-c)+1]
            end
        end
    end
    println("Ways to calculate ", target, " given coins: ", coins, ": ", ways[end])
end

prob31()
