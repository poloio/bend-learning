# The "memo" implementation is an attempt to avoid the process calculating the same number twice
# I say attempt, because in the end it created a memory problem without even solving what it needed to solve 
# (the threads can't see each other's calculations due to this language being painfuly immutable)

# Returns the result saved for a nth number if exists
def x_inmemo(memo, x):
  fold memo with x:
    case List/Cons:
      (fibx, res) = memo.head
      if fibx == x:
        return res
      else:
        return memo.tail(x)
    case List/Nil:
      return 0

# Merges two lists, see Bend's guide on List datatype
def merge_memos(memo_1, res_1, memo_2, res_2):
  to_list = List/Cons(res_1, memo_1)
  from_list = List/Cons(res_2, memo_2)
  fold to_list with from_list:
    case List/Cons:
      return List/Cons {
        head: to_list.head,
        tail: to_list.tail(from_list)
      }
    case List/Nil:
      return from_list 
    

# Gets the nth number in the fibonacci sequence, checking for already calculated numbers
def getFibonacci(n):
  bend x = n, memo = []:
    when x > 1:
      memo_content = x_inmemo(memo, x)
      if memo_content == 0:
        ((res_1, memo_1), (res_2, memo_2)) = (fork(x - 1, memo), fork(x - 2, memo))
        res_memo = merge_memos(memo_1, res_1, memo_2, res_2)
        res = res_1 + res_2
        return (res, res_memo)
      else:
        return (memo_content, memo)
    else:
      return (x, memo)

def main():
  (res, memo) = getFibonacci(10)
  return res