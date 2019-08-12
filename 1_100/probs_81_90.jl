function print_matrix(m)
    for row in m
        println(row)
    end
    println()
end

function prob81(file="./1_100/p081_matrix.txt")
    matrix = split(read(open(file), String), "\n")[1:end-1]
    m = []
    for row in matrix
        push!(m, [parse(Int, n) for n in split(row, ",")])
    end

    for i in Iterators.reverse(1:length(m))
        for j in Iterators.reverse(1:length(m))
            if i == j == length(m)
                continue
            elseif i == length(m)
                m[i][j] += m[i][j+1]
            elseif j == length(m)
                m[i][j] += m[i+1][j]
            else
                m[i][j] += min(m[i][j+1], m[i+1][j])
            end
        end
    end
    println("Minimal path sum: ", m[1][1])
end

@time prob81()
