# 🚀 GoalFlow – Ứng dụng theo dõi mục tiêu và thói quen

---

## 📌 Giới thiệu

**GoalFlow** là ứng dụng hỗ trợ người dùng theo dõi **mục tiêu cá nhân (Goal)** và xây dựng **thói quen (Habit)** mỗi ngày.
Ứng dụng giúp duy trì động lực thông qua việc ghi nhận tiến trình và nhắc nhở thường xuyên.

---

## 👥 Thành viên nhóm

* Nguyễn Minh Ánh – MASV: 23010718
* Mai Ngọc Linh – MASV: 230101717

---

## 📖 Mô tả dự án

Trong cuộc sống hiện đại, việc duy trì thói quen tốt và hoàn thành mục tiêu cá nhân là một thách thức lớn.
**GoalFlow** được xây dựng nhằm hỗ trợ người dùng:

* Theo dõi tiến trình mục tiêu
* Xây dựng thói quen tích cực
* Duy trì kỷ luật cá nhân

---

## 🎯 Đối tượng quản lý

Ứng dụng tập trung vào 3 đối tượng chính:

* 👤 **User** – người sử dụng hệ thống
* 🎯 **Goal** – mục tiêu cá nhân
* 🔥 **Habit** – thói quen hằng ngày

---

## 🧠 Nội dung bài tập (OOP)

### ✨ Câu 2: Generics

Xây dựng lớp tổng quát giúp xử lý dữ liệu linh hoạt.

📄 File:

```bash
lib/cau2_utils/generic.dart
```

---

### ✨ Câu 3: Xây dựng Class Habit

📄 File:

```bash
lib/cau3_models/habit.dart
```

#### 🔹 Thuộc tính:

* `id`
* `tenHabit`
* `tanSuat`
* `thoiGianNhac`

#### 🔹 Phương thức:

* `display()`
* `update(...)`

👉 Class Habit đại diện cho một thói quen cụ thể của người dùng.

---

### ✨ Câu 4: CRUD với ListHabit

📄 File:

```bash
lib/cau4_managers/list_habit.dart
```

#### 🔹 Danh sách:

```dart
List<Habit> habits = [];
```

#### 🔹 Chức năng:

* ✅ Create: `addHabit()`
* ✅ Read: `getAllHabits()`
* ✅ Update: `updateHabit()`
* ⭐ Delete: `deleteHabit()` (mở rộng)

👉 Class này đóng vai trò quản lý danh sách Habit và xử lý logic dữ liệu.

---
# 👤 Phần thực hiện của sinh viên: Nguyễn Minh Ánh

## 📌 Chức năng phụ trách

Sinh viên phụ trách xây dựng module quản lý Habit trong ứng dụng GoalFlow.

Bao gồm:

* Xây dựng class Habit
* Xây dựng CRUD quản lý Habit
* Áp dụng Generic để tổng quát hóa xử lý dữ liệu
* Phân tích tổng quát hóa và chuyên biệt hóa trong OOP

---

# 🧠 Phân tích tổng quát hóa và chuyên biệt hóa

## 1. Tổng quát hóa (Generic)

Trong project, nhóm thực hiện tổng quát hóa thông qua Generic class:

```dart
class DataPrinter<T> {
  T obj;

  DataPrinter(this.obj);

  void printData() {
    print(obj);
  }
}
```

### 📌 Ý nghĩa

* `T` là kiểu dữ liệu tổng quát
* Class có thể làm việc với nhiều kiểu dữ liệu khác nhau
* Không bị cố định bởi một kiểu dữ liệu cụ thể

### 📌 Mục đích

* Tái sử dụng code
* Giảm lặp code
* Dễ mở rộng hệ thống
* Thể hiện tính tổng quát hóa trong OOP

### 📌 Ví dụ sử dụng

```dart
DataPrinter<String>("Hello");
DataPrinter<int>(100);
DataPrinter<Habit>(habit);
```

---

## 2. Chuyên biệt hóa (Specialization)

Những phần không thể tổng quát hóa được sẽ được chuyên biệt hóa theo đúng chức năng nghiệp vụ.

Ví dụ:

* Class Habit được xây dựng riêng cho chức năng quản lý thói quen
* Các thuộc tính mang ý nghĩa cụ thể:

  * tenHabit
  * tanSuat
  * thoiGianNhac

### 📌 Class Habit

```dart
class Habit {
  int id;
  String tenHabit;
  String tanSuat;
  String thoiGianNhac;
```

### 📌 Ý nghĩa chuyên biệt hóa

Class Habit đại diện riêng cho đối tượng Habit trong hệ thống GoalFlow và phục vụ trực tiếp cho bài toán quản lý thói quen.

---

# 🏗️ CRUD quản lý Habit

## 📌 CREATE

```dart
void addHabit(Habit habit) {
  habits.add(habit);
}
```

## 📌 READ

```dart
void getAllHabits() {
  for (var h in habits) {
    h.display();
  }
}
```

## 📌 UPDATE

```dart
void updateHabit(int id,
    {String? tenHabit, String? tanSuat, String? thoiGianNhac}) {
```

## 📌 DELETE

```dart
void deleteHabit(int id) {
  habits.removeWhere((h) => h.id == id);
}
```

---

# 📂 File thực hiện

## 📌 Model

```bash
lib/cau3_models/habit.dart
```

## 📌 CRUD Manager

```bash
lib/cau4_managers/list_habit.dart
```

## 📌 Generic

```bash
lib/cau2_utils/generic.dart
```

---

# 🎯 Kết quả đạt được

* Áp dụng được tính tổng quát hóa bằng Generic
* Áp dụng chuyên biệt hóa với đối tượng Habit
* Xây dựng CRUD hoàn chỉnh
* Tổ chức code theo hướng OOP
* Dễ mở rộng và tái sử dụng

---

# 🔗 Link Repository

GitHub Repo:

```bash
https://github.com/NmA3108/GoalFlow_Anh_Linh_N03_1_2026
```

---

# 📸 Ảnh minh họa 

* Ảnh framework project
* Ảnh code Generic
  <img width="799" height="941" alt="image" src="https://github.com/user-attachments/assets/ad79ac85-8102-4fcd-af0c-43678492d321" />

* Ảnh code CRUD Habit
  <img width="922" height="929" alt="image" src="https://github.com/user-attachments/assets/ff215cce-0286-411d-9e4b-831eb046c707" />
* Ảnh màn hình chạy ứng dụng


---
## Bài kiểm tra giữa kỳ

## 📌 Phân công công việc (Câu 1)

Nhóm đã thảo luận và phân chia các màn hình (Screens) để phát triển ứng dụng như sau:

### 👥 Số lượng thành viên: 2

### 🔹 Nguyễn Minh Ánh
- Phụ trách xây dựng màn hình **Content**
- Thiết kế UI gồm:
  - Banner
  - List
  - Grid
- Tích hợp hình ảnh minh họa (Image Network)

### 🔹 Mai Ngọc Linh
- Phụ trách xây dựng màn hình **About**
- Hiển thị thông tin nhóm và mô tả ứng dụng

---

### 🧭 Màn hình Home
- Được phát triển dựa trên template (UI) tương tự Content
- Hiển thị:
  - Thông tin người dùng
  - Streak
  - Nhiệm vụ trong ngày

---

### 🔄 Điều hướng
- Sử dụng **Bottom Navigation Bar**
- Gồm 3 màn hình:
  - Home
  - Content
  - About

---

### 📂 Quản lý mã nguồn
- Mỗi thành viên thực hiện commit phần việc của mình lên GitHub
- Lịch sử commit thể hiện rõ quá trình làm việc của từng thành viên
## 🖥️ Giao diện

📄 File chính:

```bash
lib/main.dart
```

Ứng dụng hiển thị:

* Thông tin người dùng
* Danh sách Goal
* Danh sách Habit

👉 Giao diện đơn giản, tập trung vào hiển thị dữ liệu.

---

## ⚙️ Công nghệ sử dụng

* 💙 Flutter
* 🎯 Dart
* 🧠 OOP (Object-Oriented Programming)
* 🐳 Dev Container (Docker)
* ☁️ GitHub Codespaces

---

## 🛠️ Chức năng chính

* ✅ Tạo và quản lý mục tiêu
* ✅ Theo dõi tiến độ
* ✅ Quản lý thói quen
* ✅ Hiển thị dữ liệu rõ ràng

---

## 📂 Cấu trúc dự án

```bash
lib/
│
├── cau2_utils/
│   └── generic.dart
│
├── cau3_models/
│   └── habit.dart
│
├── cau4_managers/
│   └── list_habit.dart
│
├── front/
│   └── BotNavi.dart
│
├── pages/
│   └── content_page.dart
│
├── MyHomePage.dart
├── MyContactPage.dart
│
└── main.dart
```

---


## ▶️ Cách chạy project

```bash
flutter pub get
flutter run -d web-server
```

---

## 📝 Ghi chú

* Dự án được phát triển trên Dev Container
* Có thể chạy trực tiếp trên GitHub Codespaces
* Tập trung vào logic OOP hơn là UI

---

## 👨‍💻 Tác giả

**Nhóm N03 – GoalFlow Project**

---

