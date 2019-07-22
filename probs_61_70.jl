function length_(x::BigInt)
    length(string(x))
end

function prob63()
    """
        Number of n-digit positive integers exist which are also an nth power
    """
    cnt = 0

    for i = 1:10, j= 1:100
        if length_(BigInt(i)^j) == j
            cnt += 1
        end
    end
    println("Number of numbers of the length of their power: ",cnt)
end

@time prob63()


#-------------------------------------------------------------------------------


function prob67(file="p067_triangle.txt")
    """
    Max path from top to bottom of given triangle file
    """
    triangle = split(read(open(file), String), "\n")
    s = [[parse(Int, c) for c in split(row, " ")] for row in triangle[1:end-1]]

    for i in Iterators.reverse(1:length(s)-1)
        for j = 1:length(s[i])
            s[i][j] += max(s[i+1][j], s[i+1][j+1])
        end
    end

    println("Max path value: ", s[1][1])
end

prob67()
