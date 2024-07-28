optimized script for password 
#!/bin/bash

# Func to check pwd score and allot score 
check_password_strength() {
    local password=$1
    local score=0

    # chk len of pwd
    local len=${#password}
    if (( len < 8 )); then
        echo "Password length is less than 8 characters."
        return
    elif (( len < 12 )); then
        score=$((score + 20))
    else
        score=$((score + 40))
    fi

    # Con 1 and score allottement 
    if [[ $password =~ [[:upper:]] && $password =~ [[:lower:]] ]]; then
        score=$((score + 20))
    else
        echo "Password should contain both uppercase and lowercase letters."
    fi

    # Con 2
    if [[ $password =~ [0-9] ]]; then
        score=$((score + 20))
    else
        echo "Password should contain at least one number."
    fi

    # con 3 
    if [[ $password =~ [[:punct:]] ]]; then
        score=$((score + 20))
    else
        echo "Password should contain at least one special character."
    fi

    echo "Password strength score: $score/100"

    # judgement 
    if (( score < 60 )); then
        echo "Recommendation: You should consider changing your password."
    else
        echo "Recommendation: Your password strength is good."
    fi
}

# ex.
echo "Enter your password:"
read -s password  # '-s' flag hides input on terminal

check_password_strength "$password"