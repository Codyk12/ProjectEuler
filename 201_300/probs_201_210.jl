
function match(n)
    s = string(n)
    j = 1
    for i = 1:9
        if s[j] != string(i)[1]
            return false
        end
        j += 2
    end
    true
end

function prob206()
    n = BigInt(0)
    for i = Iterators.reverse(1010101010:1389026623)
        if match(BigInt(i)^2)
            n = i
            break
        end
    end
    println("Square root of matching pattern: ", n)
end

@time prob206()
