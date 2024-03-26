#!/bin/bash

# Task 1
task1() {
    find /usr/bin -type f -name 'c*' -exec basename {} \;
}

# Task 2
task2() {
    find /usr/bin -type l -name '*sh*' -exec basename {} \;
}

# Task 3
task3() {
    find /usr | head -n 10
}

# Task 4
task4() {
    grep "model name" /proc/cpuinfo
}

# Task 5
task5() {
    grep -cv "sudo" /etc/group
}

# Task 6
task6() {
    grep -n "sudo" /etc/group
}

# Task 7
task7() {
    sort food
}

# Task 8
task8() {
    sort -r food
}

# Task 9
task9() {
    sort -k 2 food
}

# Task 10
task10() {
    sort -rnk3,3 -k2,2 food > calo
}

# Task 11
task11() {
    git tag L.09
}

# Call the respective function based on command-line argument
case $1 in
    "task1") task1 ;;
    "task2") task2 ;;
    "task3") task3 ;;
    "task4") task4 ;;
    "task5") task5 ;;
    "task6") task6 ;;
    "task7") task7 ;;
    "task8") task8 ;;
    "task9") task9 ;;
    "task10") task10 ;;
    "task11") task11 ;;
    *) echo "Invalid task number"; exit 1 ;;
esac
