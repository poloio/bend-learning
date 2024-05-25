def main():
  bend x = 21:
    when x > 1:
      res = fork(x - 1) + fork(x - 2)
    else:
      res = x
  return res