
function prob51(args)
    body
end



#-------------------------------------------------------------------------------

function mult_same_digits(i::Int)
    Set(string(i)) == Set(string(2i)) == Set(string(3i)) == Set(string(4i)) == Set(string(5i)) == Set(string(6i))
end

function prob52()
    """
    finds smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

    """
    i = 9
    while true
        if i % 10 != 0 && mult_same_digits(i)
            println("Smallest same digits number: ", i)
            return
        end
        i += 1
    end
end


@time prob52()


#-------------------------------------------------------------------------------
using Combinatorics

function prob53()
    """
        Number of binomial 1 < n < 100 above 1 million
    """
    cnt = 0
    for n = 23:100
        for r = 1:n
            if binomial(BigInt(n), r) > 1000000
                cnt += 1
            end
        end
    end
    println("Over 1 million: ", cnt)
end

@time prob53()

#-------------------------------------------------------------------------------

function winner(h1, h2)
    type_rank = Dict()
    type_rank["HC"] = 1
    type_rank["1P"] = 2
    type_rank["2P"] = 3
    type_rank["3K"] = 4
    type_rank["ST"] = 5
    type_rank["FL"] = 6
    type_rank["FH"] = 7
    type_rank["4K"] = 8
    type_rank["SF"] = 9
    type_rank["RF"] = 10

    card_rank = Dict()
    card_rank['1'] = 2
    card_rank['2'] = 3
    card_rank['3'] = 4
    card_rank['4'] = 5
    card_rank['5'] = 6
    card_rank['6'] = 7
    card_rank['7'] = 8
    card_rank['8'] = 9
    card_rank['9'] = 10
    card_rank['T'] = 11
    card_rank['J'] = 12
    card_rank['Q'] = 13
    card_rank['K'] = 14
    card_rank['A'] = 15

    h1_t, num_1 = get_hand_type(h1, card_rank)
    h2_t, num_2 = get_hand_type(h2, card_rank)

    if type_rank[h2_t] < type_rank[h1_t]
        return 1
    elseif type_rank[h1_t] < type_rank[h2_t]
        return 2
    else
        num_1 > num_2 && return 1
        return higher_card(h1, h2, card_rank)
    end
end

function higher_card(h1, h2, card_rank)
    h1_cr = reverse!(sort!([card_rank[c[1]] for c in h1]))
    h2_cr = reverse!(sort!([card_rank[c[1]] for c in h2]))
    h1_cr > h2_cr ? 1 : 2
end


function get_hand_type(h, card_rank)
    is, num = is_royal_flush(h)
    is != "" && return is, num
    is, num = is_straight_flush(h, card_rank)
    is != "" && return is, num
    is, num = is_4_kind(h, card_rank)
    is != "" && return is, num
    is, num = is_full_house(h, card_rank)
    is != "" && return is, num
    is, num = is_flush(h, card_rank)
    is != "" && return is, num
    is, num = is_straight(h, card_rank)
    is != "" && return is, num
    is, num = is_three_kind(h, card_rank)
    is != "" && return is, num
    is, num = is_two_pairs(h, card_rank)
    is != "" && return is, num
    is, num = is_one_pair(h, card_rank)
    is != "" && return is, num
    "HC", sort_by_rank(h,card_rank)[end]
end

function is_royal_flush(hand)
    if prod([x in [c[1] for c in hand] for x in ['T', 'J', 'Q', 'K', 'A']]) && same_suit(hand)
        return "RF", 15
    end
    "", 0
end

function is_straight_flush(hand, card_rank)
    if straight(hand, card_rank) && same_suit(hand)
        return "SF", sort_by_rank(hand,card_rank)[end]
    end
    "", 0
end

function is_4_kind(hand, card_rank)
    h = sort_by_rank(hand, card_rank)
    if (h[1] == h[2] == h[3] == h[4])
        return "4K", h[1]
    elseif (h[2] == h[3] == h[4] == h[5])
        return "4k", h[2]
    end
    "", 0
end

function is_full_house(hand, card_rank)
    h = sort_by_rank(hand, card_rank)
    if (h[1] == h[2] == h[3] && h[4] == h[5]) || (h[1] == h[2] && h[3] == h[4] == h[5])
        return "FH", [h[5], h[1]]
    end
    "", 0
end

function is_flush(hand, card_rank)
    if same_suit(hand)
        return "FL", sort_by_rank(hand,card_rank)[end]
    end
    "", 0
end

function is_straight(hand, card_rank)
    if straight(hand, card_rank)
        return "ST", sort_by_rank(hand,card_rank)[end]
    end
    "", 0
end

function is_three_kind(hand, card_rank)
    h = sort_by_rank(hand, card_rank)
    if (h[1] == h[2] == h[3]) || (h[2] == h[3] == h[4]) || (h[3] == h[4] == h[5])
        return "3K", h[3]
    end
    "", 0
end

function is_two_pairs(hand, card_rank)
    h = sort_by_rank(hand,card_rank)
    cnt = 0
    num = 0
    for i = 1:length(h)-1
        if (h[i] == h[i+1])
            cnt += 1
            num = h[i]
        end
    end
    cnt == 2 && return "2P", num
    "", 0
end

function is_one_pair(hand,card_rank)
    h = sort_by_rank(hand,card_rank)
    for i = 1:length(h)-1
        if (h[i] == h[i+1])
            return "1P", h[i]
        end
    end
    "", 0
end

function same_suit(h)
    (h[1][2] == h[2][2] == h[3][2] == h[4][2] == h[5][2])
end

function sort_by_rank(h, card_rank)
    sort!([card_rank[c[1]] for c in h])
end

function straight(hand, card_rank)
    h = sort_by_rank(hand, card_rank)
    (h[1] == h[2]-1 == h[3]-2 == h[4]-3 == h[5]-4)
end

function prob54(file="./1_100/p054_poker.txt")
    hnds = split(read(open(file), String), "\n")[1:end-1]
    win_cnt = 0
    for h in hnds
        h1 = split(h[1:14], " ")
        h2 = split(h[16:end], " ")
        if winner(h1, h2) == 1
            win_cnt += 1
        end
    end
    println("Player One wins: ", win_cnt, " times")
end

@time prob54()

#-------------------------------------------------------------------------------

function ispalendrome(n::Integer)
    """
    Checks if number is palendrome
    """
    n = string(n)
    for i = 1:Int(ceil(length(n)/2))
        if n[i] != n[end-i+1]
            return false
        end
    end
    true
end

ispalendrome(132)

function prob55()
    """
        Lychrel numbers that are below ten-thousand
    """
    cnt = 0
    for i = 10:10000
        num = BigInt(i)
        is_pal = false
        for j = 1:50
            num += parse(BigInt, reverse(string(num)))
            if ispalendrome(num)
                is_pal = true
                break
            end
        end
        cnt += !is_pal ? 1 : 0
    end
    println(cnt, " Lychrel numbers are below ten-thousand")
end

@time prob55()


#-------------------------------------------------------------------------------

function digitsum(n)
    sum([parse(Int, c) for c in string(n)])
end


function prob56(n=100)
    max_sum = 0
    for a = 1:n, b = 1:n
        if a % 10 != 0
            sum = digitsum(BigInt(a)^b)
            if sum > max_sum
                max_sum = sum
            end
        end
    end
    println("Max sum of digits of a^b (a,b<", n, "): ", max_sum)
end

@time prob56()

#-------------------------------------------------------------------------------

function sqrt2_recurse(n, i)
    """
    Recurse for sqrt(2)
    """
    if i == n
        return 1//BigInt(2)
    else
        return 1 // (2 + sqrt2_recurse(n, i+1))
    end
end

function prob57(n=1000)
    """
    find number of fraction with numerator having more digits
    than denominator in the first n iterations for sqrt(2)
    """
    cnt = 0
    for i = 1:n
        frac = 1 + sqrt2_recurse(i, 1)
        if length(string(frac.num)) > length(string(frac.den))
            cnt += 1
        end
    end
    println("Num of numbers with larger numerator: ", cnt)

end

@time prob57()


#-------------------------------------------------------------------------------
using Primes

function prob58(percent=.1)
    """
        Finds the side legnth of spiral numbers for the ratio of primes
        to total diagonals is less than n
    """
    num = 1
    primes = 0
    diags = 1
    side_length = 1
    while true
        side_length += 2
        for i = 1:4
            num+=(side_length-1)
            isprime(num) && (primes += 1)
            diags += 1
        end
        if primes / diags <= percent
            break
        end
    end
    println("Side length required for less than ", 100*percent, "% primes on diagonals: ",  side_length )

end

@time prob58()

#-------------------------------------------------------------------------------

function encrypt(message::Vector{Int}, key::String)
    key = [Int(k) for k in key]
    println(key)
    n = length(key)
    new_message = Vector{Int}()
    i = 0
    for m in message
        i == 3 ? i = 1 : i += 1
        println(i)
        push!(new_message, m ⊻ key[i])
    end
    new_message
end

function readable(message::Vector{Int})
    prod([Char(m) for m in message])
end

function intersections(piles)
    inter = []
    for (i,pile) in enumerate(piles)
        push!(inter, intersect(pile...))
    end
    inter, [readable(i) for i in inter]
end

function isvalid_(message::Vector{Int}, keys::Vector{Int})
    valid = vcat([32,33,34,39,40,41,44,45,46,63], collect(48:59), collect(65:90),collect(97:122))
    key = prod([Char(k) for k in keys])
    new_message = encrypt(message, prod([Char(k) for k in keys]))

    if key == "god"
        println("hey ", key)
        # println(new_message)
        println(readable(message))
    end
    for m in message
        if !(m in valid)
            key == "god" ? println("not in valid!! ",m) : nothing
            return false
        end
    end
    true
end


function prob59_(n=3, file="p059_cipher.txt")
    str = map(x->parse(Int,x), split(read(open(file), String), ","))
    println(str[1])
    readable(encrypt(str, "god"))
    # i = 0
    # a, b, c = str[i+=1], str[i+=1], str[i+=1]
    # for i = 97:122, j = 97:122, k = 97:122
    #     if isvalid_(str, [i, j, k])
    #         return i, j, k
    #     end
    # end
    # print("woops")
end

prob59_()


#
# function prob59(n=3, file="p059_cipher.txt")
#     str = map(x->parse(Int,x), split(read(open(file), String), ","))
#     i = 0
#     pile1 = Vector{Vector{Int}}()
#     pile2 = Vector{Vector{Int}}()
#     pile3 = Vector{Vector{Int}}()
#     piles = [pile1,pile2,pile3]
#     while i < length(str)
#         println()
#         for k = 1:3
#             s = str[i+k]
#             v = Vector{Int}()
#             for j = 97:122
#                 if (32 <= (s ⊻ j) <= 126)
#                     push!(v, j)
#                 end
#             end
#             push!(piles[k], v)
#         end
#         i += 3
#     end
#     intersections(piles)
#
# end
#
# @time piles = prob59()
