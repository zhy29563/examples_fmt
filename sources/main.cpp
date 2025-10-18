#include <fmt/core.h>
#include <fmt/format.h>
#include <fmt/printf.h>

#include <iostream>
#include <string>
#include <vector>

int main() {
  // 基本格式化示例
  std::string message = fmt::format("Hello, {}!", "World");
  fmt::print("{}\n", message);

  // 数字格式化
  int value = 42;
  fmt::print("The answer is {}\n", value);

  // 浮点数格式化
  double pi = 3.14159265359;
  fmt::print("Pi is approximately {:.2f}\n", pi);

  // 多参数格式化
  std::string name = "Alice";
  int         age  = 30;
  fmt::print("{} is {} years old\n", name, age);

  // 使用printf风格的格式化
  fmt::printf("Printf-style: %s is %d years old\n", name.c_str(), age);

  // 容器格式化
  std::vector<int> numbers = {1, 2, 3, 4, 5};
  fmt::print("Numbers: {}\n", fmt::join(numbers, ", "));

  // 错误处理示例
  try {
    // 这会抛出异常，因为参数数量不匹配
    std::string error = fmt::format("Hello, {} {}!", "World");
  } catch (const std::exception& e) {
    fmt::print("Error: {}\n", e.what());
  }

  // 格式化到字符串并返回长度
  std::string formatted = fmt::format("Formatted string with {} and {:.3f}", 42, 3.14159);
  fmt::print("Length of formatted string: {}\n", formatted.length());
  fmt::print("Formatted string: {}\n", formatted);

  return 0;
}