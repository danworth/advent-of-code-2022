
print("STARTING")
lines=[]

for line in open("input.txt").readlines():
    if line != "\n":
        lines.append(list(line.replace("\n", "")))

total = 1
discovered_trees = set()


# Go from left
for row in range(0, len(lines)):
    biggest_tree=-1
    for col in range(0, len(lines[row])):
        curr_tree = int(lines[row][col])
        cood = f'{row}:{col}'

        if curr_tree > biggest_tree:
            biggest_tree = curr_tree
            if cood not in discovered_trees:
                discovered_trees.add(cood)
                total += 1

# Go from right
for row in range(0, len(lines)):
    biggest_tree=-1
    for col in reversed(range(0, len(lines[row]))):
        curr_tree = int(lines[row][col])
        cood = f'{row}:{col}'

        if curr_tree > biggest_tree:
            biggest_tree = curr_tree
            if cood not in discovered_trees:
                discovered_trees.add(cood)
                total += 1

# Go from top
for col in range(0, len(lines[0])):
    biggest_tree=-1
    for row in range(0, len(lines)):
        curr_tree = int(lines[row][col])
        cood = f'{row}:{col}'


        if curr_tree > biggest_tree:
            biggest_tree = curr_tree
            if cood not in discovered_trees:
                discovered_trees.add(cood)
                total += 1

# Go from bottom
for col in range(0, len(lines[0])):
    biggest_tree=-1
    for row in reversed(range(0, len(lines))):
        curr_tree = int(lines[row][col])
        cood = f'{row}:{col}'


        if curr_tree > biggest_tree:
            biggest_tree = curr_tree
            if cood not in discovered_trees:
                discovered_trees.add(cood)
                total += 1
print(total)


print("Part II")
maximum_view=0
for row in range(0, len(lines)):
    for col in range(0, len(lines[row])):
        total = 1
        left = 0
        right = 0
        up = 0
        down = 0

        curr_tree = int(lines[row][col])
        # Go left
        if col > 0 :
            for i in reversed(range(0, col)):
                left += 1
                if int(lines[row][i]) >= curr_tree:
                    break

        # Go right
        if col < len(lines[row]):
            for i in range(col + 1, len(lines[row])):
                right += 1
                if int(lines[row][i]) >= curr_tree:
                    break

        # Go up
        if row > 0:
            for i in reversed(range(0, row)):
                up += 1
                if int(lines[i][col]) >= curr_tree:
                    break

        # Go down
        if row < len(lines):
            for i in range(row + 1, len(lines)):
                down += 1
                if int(lines[i][col]) >= curr_tree:
                    break

        total = left * right * up * down
        if total > maximum_view:
            maximum_view = total

print(f'Maximum view: {maximum_view}')

