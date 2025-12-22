<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="CarRental.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ===== HOME PAGE ===== */

        /* HERO SECTION */
        .home-hero {
            background: linear-gradient(rgba(31, 41, 55, 0.7))
                ,url('/Image/Home/HeroBackground.png') center/cover;
            color: white;
            padding: 120px 20px 100px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .home-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><rect width="100" height="100" fill="none"/><path d="M0 50 Q 25 25, 50 50 T 100 50" stroke="rgba(239,68,68,0.1)" fill="none" stroke-width="2"/></svg>');
            opacity: 0.3;
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

            .hero-content h1 {
                font-size: 48px;
                font-weight: 700;
                margin-bottom: 20px;
                line-height: 1.2;
            }

            .hero-content p {
                font-size: 20px;
                color: #d1d5db;
                margin-bottom: 35px;
                font-weight: 400;
            }

        .btn-primary {
            display: inline-block;
            background: #ef4444;
            color: white;
            padding: 16px 40px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

            .btn-primary:hover {
                background: #dc2626;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            }

        /* FEATURES SECTION */
        .home-features {
            max-width: 1200px;
            margin: 80px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .feature {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            transition: all 0.3s;
            border: 1px solid #f3f4f6;
        }

            .feature:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 24px rgba(0,0,0,0.1);
                border-color: #ef4444;
            }

            .feature i {
                font-size: 48px;
                color: #ef4444;
                margin-bottom: 20px;
                transition: transform 0.3s;
            }

            .feature:hover i {
                transform: scale(1.1);
            }

            .feature h3 {
                margin-bottom: 12px;
                font-size: 20px;
                font-weight: 600;
                color: #1f2937;
            }

            .feature p {
                color: #6b7280;
                font-size: 15px;
                line-height: 1.6;
            }

        /* POPULAR VEHICLES SECTION */
        .home-vehicles {
            background: #f9fafb;
            padding: 80px 20px;
            text-align: center;
        }

            .home-vehicles h2 {
                font-size: 36px;
                font-weight: 700;
                margin-bottom: 50px;
                color: #1f2937;
            }

        .vehicle-list {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }

        .vehicle-card {
            background: white;
            border-radius: 12px;
            padding: 0;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            transition: all 0.3s;
            overflow: hidden;
            border: 1px solid #f3f4f6;
        }

            .vehicle-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 12px 32px rgba(0,0,0,0.12);
            }

            .vehicle-card .img-container {
                width: 100%;
                height: 200px;
                overflow: hidden;
                background: #f3f4f6;
            }

            .vehicle-card img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s;
            }

            .vehicle-card:hover img {
                transform: scale(1.05);
            }

            .vehicle-card h4 {
                font-size: 20px;
                font-weight: 600;
                margin: 20px 20px 10px;
                color: #1f2937;
            }

            .vehicle-card p {
                color: #6b7280;
                margin: 0 20px 20px;
                font-size: 15px;
            }

                .vehicle-card p strong {
                    color: #ef4444;
                    font-size: 18px;
                }

        .btn-outline {
            display: inline-block;
            padding: 12px 30px;
            border-radius: 8px;
            border: 2px solid #ef4444;
            color: #ef4444;
            text-decoration: none;
            transition: all 0.3s;
            font-weight: 600;
            margin: 0 20px 25px;
        }

            .btn-outline:hover {
                background: #ef4444;
                color: white;
            }

        /* PROCESS SECTION */
        .home-process {
            padding: 80px 20px;
            text-align: center;
            background: white;
        }

            .home-process h2 {
                font-size: 36px;
                font-weight: 700;
                margin-bottom: 50px;
                color: #1f2937;
            }

        .process-list {
            max-width: 1000px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
        }

        .process-step {
            background: #f9fafb;
            padding: 40px 30px;
            border-radius: 12px;
            transition: all 0.3s;
            border: 2px solid transparent;
        }

            .process-step:hover {
                border-color: #ef4444;
                background: white;
                box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            }

            .process-step span {
                display: inline-block;
                width: 60px;
                height: 60px;
                line-height: 60px;
                border-radius: 50%;
                background: #ef4444;
                color: white;
                font-weight: 700;
                font-size: 24px;
                margin-bottom: 20px;
                transition: transform 0.3s;
            }

            .process-step:hover span {
                transform: scale(1.1);
            }

            .process-step p {
                font-size: 16px;
                color: #1f2937;
                font-weight: 500;
            }

        /* Responsive */
        @media (max-width: 768px) {
            .hero-content h1 {
                font-size: 36px;
            }

            .hero-content p {
                font-size: 18px;
            }

            .home-vehicles h2,
            .home-process h2 {
                font-size: 28px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <!-- HERO -->
    <section class="home-hero">
        <div class="hero-content">
            <h1>Thuê xe dễ dàng – Giá minh bạch</h1>
            <p>Đặt xe nhanh, không phí ẩn, hỗ trợ tận tâm 24/7</p>
            <a href="VehicleList.aspx" class="btn-primary">Xem xe ngay</a>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="home-features">
        <div class="feature">
            <i class="fa-solid fa-car"></i>
            <h3>Đa dạng dòng xe</h3>
            <p>Sedan, SUV, bán tải, xe gia đình và xe du lịch</p>
        </div>

        <div class="feature">
            <i class="fa-solid fa-file-signature"></i>
            <h3>Thủ tục nhanh</h3>
            <p>Chỉ cần CCCD & bằng lái, nhận xe trong 10 phút</p>
        </div>

        <div class="feature">
            <i class="fa-solid fa-shield-halved"></i>
            <h3>An tâm tuyệt đối</h3>
            <p>Bảo hiểm đầy đủ, xe kiểm tra định kỳ</p>
        </div>
    </section>

    <!-- POPULAR VEHICLES -->
    <section class="home-vehicles">
        <h2>Xe được thuê nhiều</h2>

        <div class="vehicle-list">
            <div class="vehicle-card">
                <div class="img-container">
                    <img src="/Image/Vehicle/FordRanger.jpg" alt="Ford Ranger" />
                </div>
                <h4>Ford Ranger</h4>
                <p>Giá từ <strong>900.000đ/ngày</strong></p>
                <a href="VehicleList.aspx" class="btn-outline">Thuê ngay</a>
            </div>

            <div class="vehicle-card">
                <div class="img-container">
                    <img src="/Image/Vehicle/ToyotaInnova.jpg" alt="Toyota Innova" />
                </div>
                <h4>Toyota Innova</h4>
                <p>Giá từ <strong>600.000đ/ngày</strong></p>
                <a href="VehicleList.aspx" class="btn-outline">Thuê ngay</a>
            </div>

            <div class="vehicle-card">
                <div class="img-container">
                    <img src="/Image/Vehicle/KiaCanival.jpg" alt="Kia Canival" />
                </div>
                <h4>Kia Canival</h4>
                <p>Giá từ <strong>900.000đ/ngày</strong></p>
                <a href="VehicleList.aspx" class="btn-outline">Thuê ngay</a>
            </div>
        </div>
    </section>

    <!-- PROCESS -->
    <section class="home-process">
        <h2>Thuê xe chỉ với 3 bước</h2>

        <div class="process-list">
            <div class="process-step">
                <span>1</span>
                <p>Chọn xe phù hợp</p>
            </div>

            <div class="process-step">
                <span>2</span>
                <p>Đặt lịch thuê</p>
            </div>

            <div class="process-step">
                <span>3</span>
                <p>Nhận xe & khởi hành</p>
            </div>
        </div>
    </section>
</asp:Content>
