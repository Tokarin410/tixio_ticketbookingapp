# ticketcon

Final Project for App mobile course

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,

## Troubleshooting Common Issues (Các lỗi thường gặp)

### 1. Lỗi Google Sign-In (Login failed/Exception)
Nếu gặp lỗi biên dịch liên quan đến `GoogleSignIn` hoặc `accessToken`:
- **Nguyên nhân:** Phiên bản `google_sign_in` mới (v7.0+) có thay đổi lớn gây lỗi với code cũ.
- **Cách sửa:**
  1. Mở file `pubspec.yaml`, đảm bảo dòng này là: `google_sign_in: ^6.2.1`
  2. Chạy lệnh: `flutter clean` sau đó `flutter pub get`.

### 2. Lỗi Gradle / Java Home (Exception: 25.0.1)
Nếu gặp lỗi build "What went wrong: 25.0.1":
- **Nguyên nhân:** Máy đang cài Java 25 (quá mới), Gradle chưa hỗ trợ.
- **Cách sửa:**
  1. Sửa biến môi trường `JAVA_HOME` trỏ về JDK 17 hoặc thấp hơn.
  2. Hoặc cấu hình Android Studio dùng JDK nhúng (Embedded JDK).

### 3. App bị đơ ở logo (White screen)
- **Nguyên nhân:** Xung đột giữa màn hình chờ (Splash) và kiểm tra đăng nhập.
- **Cách sửa:** Đã xử lý trong `Wrapper.dart` bằng cách thêm vòng xoay Loading.
