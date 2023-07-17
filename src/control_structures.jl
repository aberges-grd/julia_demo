z = begin
x = 1
y = 2
x + y
end
# equivalente
z = (x=1; y=2; x+y)

A = [1 2 3 4]
for x in A  # también vale: for x ∈ A
    print(x)
end

i = 1
while i <= 3
    println(i)
    global i += 1
end

x = 1; y = 2
if x < y
    println("x is less than y")
elseif x > y
    println("x is greater than y")
else
    println("x is equal to y")
end
# pero también
println(x < y ? "less than" : "not less than")

try
    sqrt("ten")
catch e
    println("You should have entered a numeric value")
end
