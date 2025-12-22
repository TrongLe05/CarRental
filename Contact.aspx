<%@ Page Title="" Language="C#" MasterPageFile="~/SiteCustomer.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="CarRental.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        /* ===== CONTACT PAGE ===== */

        /* BANNER SECTION */
        .contact-banner {
            background: linear-gradient(135deg, rgba(31, 41, 55, 0.95) 0%, rgba(17, 24, 39, 0.98) 100%), url('https://images.unsplash.com/photo-1423666639041-f56000c27a9a?w=1920&q=80') center/cover;
            color: white;
            padding: 100px 20px 80px;
            text-align: center;
            position: relative;
        }

            .contact-banner h1 {
                font-size: 42px;
                font-weight: 700;
                margin-bottom: 15px;
            }

            .contact-banner p {
                color: #d1d5db;
                font-size: 18px;
                font-weight: 400;
            }

        /* CONTENT SECTION */
        .contact-section {
            padding: 80px 20px;
            background: #f9fafb;
        }

        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1.5fr;
            gap: 50px;
            align-items: start;
        }

        /* CONTACT INFO */
        .contact-info {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            border: 1px solid #f3f4f6;
        }

            .contact-info h2 {
                margin-bottom: 30px;
                font-size: 24px;
                font-weight: 700;
                color: #1f2937;
            }

            .contact-info p {
                margin-bottom: 20px;
                font-size: 16px;
                color: #4b5563;
                display: flex;
                align-items: center;
                padding: 12px;
                border-radius: 8px;
                transition: all 0.2s;
            }

                .contact-info p:hover {
                    background: #f9fafb;
                    transform: translateX(5px);
                }

            .contact-info i {
                color: #ef4444;
                margin-right: 15px;
                font-size: 18px;
                width: 24px;
                text-align: center;
            }

        /* CONTACT FORM */
        .contact-form {
            background: white;
            padding: 50px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            border: 1px solid #f3f4f6;
        }

            .contact-form h2 {
                margin-bottom: 30px;
                font-size: 24px;
                font-weight: 700;
                color: #1f2937;
            }

        .contact-input {
            width: 100%;
            padding: 16px 18px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            font-size: 15px;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            transition: all 0.3s;
            background: #f9fafb;
        }

            .contact-input:focus {
                outline: none;
                border-color: #ef4444;
                background: white;
                box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
            }

            .contact-input::placeholder {
                color: #9ca3af;
            }

            .contact-input.textarea {
                height: 160px;
                resize: vertical;
                min-height: 120px;
                max-height: 300px;
            }

        .btn-primary {
            background: #ef4444;
            color: white;
            border: none;
            padding: 16px 40px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            width: 100%;
        }

            .btn-primary:hover {
                background: #dc2626;
                transform: translateY(-2px);
                box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            }

            .btn-primary:active {
                transform: translateY(0);
            }

        /* Responsive */
        @media (max-width: 768px) {
            .contact-banner h1 {
                font-size: 32px;
            }

            .contact-banner p {
                font-size: 16px;
            }

            .contact-container {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .contact-form {
                padding: 30px;
            }

            .contact-info {
                padding: 30px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <!-- BANNER -->
    <section class="contact-banner">
        <h1>Liên hệ với chúng tôi</h1>
        <p>Chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
    </section>

    <!-- CONTACT CONTENT -->
    <section class="contact-section">
        <div class="contact-container">

            <!-- INFO -->
            <div class="contact-info">
                <h2>Thông tin liên hệ</h2>

                <p>
                    <i class="fa-solid fa-location-dot"></i>
                    Cao Lãnh, Đồng Tháp
                </p>

                <p>
                    <i class="fa-solid fa-phone"></i>
                    0909 123 456
                </p>

                <p>
                    <i class="fa-solid fa-envelope"></i>
                    support@chothuexe3conca.vn
                </p>

                <p>
                    <i class="fa-solid fa-clock"></i>
                    24/24H (T2 – CN)
                </p>
            </div>

            <!-- FORM -->
            <div class="contact-form">
                <h2>Gửi tin nhắn</h2>

                <asp:TextBox ID="txtName" runat="server"
                    CssClass="contact-input" placeholder="Họ và tên" />

                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="contact-input" placeholder="Email" />

                <asp:TextBox ID="txtMessage" runat="server"
                    CssClass="contact-input textarea"
                    TextMode="MultiLine"
                    placeholder="Nội dung liên hệ" />

                <asp:Button ID="btnSend" runat="server"
                    Text="Gửi liên hệ"
                    CssClass="btn-primary" />

            </div>

        </div>
    </section>
</asp:Content>
