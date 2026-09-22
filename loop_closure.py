# Loop Closure - Kya robot wapas purani jagah aaya?
def check_loop(old_place, new_place):
    if old_place == new_place:
        print("Haan! Robot wapas purani jagah par aa gaya")
        return True
    else:
        print("Nahi, ye nayi jagah hai")
        return False

# Example
check_loop("Class A", "Class A")
