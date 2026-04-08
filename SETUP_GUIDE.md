# 📱 GoalFlow - Hướng dẫn cài đặt môi trường phát triển

## ✅ Cài đặt đã hoàn thành

Môi trường phát triển Flutter đã được cấu hình đầy đủ cho dự án GoalFlow.

### Thông tin hệ thống

```bash
Flutter Version: 3.43.0-1.0.pre-502
Dart Version: 3.12.0
OS: Ubuntu 24.04.3 LTS
Status: ✓ Sẵn sàng code
```

## 📂 Cấu trúc dự án

```
goalflow/
├── lib/
│   ├── main.dart              # Điểm vào chính
│   ├── screens/               # Các màn hình UI
│   ├── widgets/               # Widget tái sử dụng
│   ├── models/                # Data models
│   └── services/              # Business logic & APIs
├── test/                      # Unit tests
├── pubspec.yaml              # Dependencies
├── analysis_options.yaml     # Lint rules
└── android/ios/web/          # Platform-specific code
```

## 🚀 Lệnh cơ bản

### Chạy ứng dụng (Web - dành cho Dev Container)

```bash
cd goalflow
flutter run -d web-server
```

Truy cập: http://localhost:9090 hoặc theo URL được hiển thị

### Cài đặt dependencies

```bash
cd goalflow
flutter pub get
```

### Phân tích mã

```bash
cd goalflow
flutter analyze
```

### Format code

```bash
cd goalflow
dart format lib/
```

### Chạy tests

```bash
cd goalflow
flutter test
```

### Build web (production)

```bash
cd goalflow
flutter build web
```

## 📝 Bắt đầu coding

### 1. Edit `lib/main.dart`

Đây là điểm vào của ứng dụng. Bắt đầu từ đây để modify giao diện chính.

### 2. Tạo screens

Tạo file trong `lib/screens/`:
- `home_screen.dart` - Màn hình chính
- `goal_detail_screen.dart` - Chi tiết mục tiêu
- `add_goal_screen.dart` - Thêm mục tiêu mới

### 3. Tạo widgets

Tạo file trong `lib/widgets/` cho các widget tái sử dụng:
- `goal_card.dart`
- `progress_bar.dart`
- `habit_checkbox.dart`

### 4. Tạo models

Tạo file trong `lib/models/`:
- `goal.dart` - Model cho mục tiêu
- `habit.dart` - Model cho thói quen
- `progress.dart` - Model cho tiến độ

### 5. Tạo services

Tạo file trong `lib/services/` cho logic business:
- `goal_service.dart`
- `storage_service.dart`
- `notification_service.dart`

## 🔧 VS Code Extensions (Được khuyến khích)

Cài đặt các extension sau cho trải nghiệm tốt hơn:

- **Flutter** (Dart Code)
- **Dart** (Dart Code)
- **Better Comments** - Highlighting comments
- **Thunder Client** - API testing (tùy chọn)

## 📦 Thêm dependencies

Để thêm package mới:

```bash
cd goalflow
flutter pub add package_name
# Hoặc cụ thể hơn
flutter pub add provider   # State management
flutter pub add sqflite    # Local database
flutter pub add intl       # Localization
```

## 🐛 Troubleshooting

### Lỗi "Unable to find chrome"

Đối với Dev Container, web platform là cách chạy tốt nhất. Sử dụng:

```bash
flutter run -d web-server
```

### Lỗi pub dependencies

```bash
cd goalflow
flutter clean
flutter pub get
```

### Lỗi Gradle (Android)

Bỏ qua nếu chỉ phát triển cho web. Không cần cài Android SDK.

## ✨ Mục tiêu phát triển GoalFlow

### Phase 1: UI cơ bản
- [ ] Màn hình chính hiển thị danh sách mục tiêu
- [ ] Form thêm mục tiêu mới
- [ ] Giao diện chi tiết từng mục tiêu

### Phase 2: Quản lý dữ liệu
- [ ] Lưu trữ dữ liệu cục bộ (SQLite hoặc Hive)
- [ ] Cập nhật tiến độ
- [ ] Xóa/sửa mục tiêu

### Phase 3: Tính năng nâng cao
- [ ] Thông báo nhắc nhở
- [ ] Thống kê & biểu đồ tiến độ
- [ ] Tuân thủ thói quen

### Phase 4: Polish
- [ ] Tối ưu hóa UI/UX
- [ ] Testing toàn diện
- [ ] Documentation

## 📚 Tài liệu tham khảo

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart API Reference](https://api.dart.dev)
- [Material Design Guidelines](https://material.io/design)

## 👥 Team

- Nguyễn Minh Ánh - MASV: 23010718
- Mai Ngọc Linh - MASV: 230101717

---

**Happy coding! 🎉**
