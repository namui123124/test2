<?php
session_start(); // เริ่มต้น session

// ตรวจสอบว่ามีการส่งข้อมูลฟอร์มมาหรือไม่
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // ข้อมูลจากฟอร์ม
    $username = $_POST["username"];
    $password = $_POST["password"];

    // เชื่อมต่อกับฐานข้อมูลและตรวจสอบข้อมูล
    $servername = "localhost";
    $db_username = "your_database_username";
    $db_password = "your_database_password";
    $database = "your_database_name";

    $conn = new mysqli($servername, $db_username, $db_password, $database);

    // ตรวจสอบการเชื่อมต่อ
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // ตรวจสอบข้อมูลล็อคอิน
    $sql = "SELECT * FROM users WHERE username='$username'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        // ตรวจสอบรหัสผ่าน
        if (password_verify($password, $row["password"])) {
            // ล็อคอินสำเร็จ
            $_SESSION["username"] = $username; // เก็บข้อมูลล็อคอินใน session
            echo "Login successful!";
        } else {
            // ล็อคอินไม่สำเร็จ
            echo "Login failed. Invalid username or password.";
        }
    } else {
        // ล็อคอินไม่สำเร็จ
        echo "Login failed. Invalid username or password.";
    }

    // ปิดการเชื่อมต่อกับฐานข้อมูล
    $conn->close();
}
?>
