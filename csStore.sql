USE [master]
GO
/****** Object:  Database [CdStore]    Script Date: 04/10/2020 18:52:07 ******/
CREATE DATABASE [CdStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cdStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\cdStore.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cdStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\cdStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CdStore] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CdStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CdStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CdStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CdStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CdStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CdStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [CdStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CdStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CdStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CdStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CdStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CdStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CdStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CdStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CdStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CdStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CdStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CdStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CdStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CdStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CdStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CdStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CdStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CdStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CdStore] SET  MULTI_USER 
GO
ALTER DATABASE [CdStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CdStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CdStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CdStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CdStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CdStore] SET QUERY_STORE = OFF
GO
USE [CdStore]
GO
/****** Object:  Table [dbo].[Cds]    Script Date: 04/10/2020 18:52:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cds](
	[Id] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[Album] [varchar](25) NOT NULL,
	[Singer] [varchar](25) NOT NULL,
	[Gerne] [varchar](25) NULL,
	[Price] [float] NOT NULL,
	[Storage] [int] NOT NULL,
 CONSTRAINT [PK_Cds] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 04/10/2020 18:52:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [numeric](3, 0) IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Surname] [varchar](20) NOT NULL,
	[FavoriteBand] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Phone] [numeric](8, 0) NOT NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sales]    Script Date: 04/10/2020 18:52:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales](
	[Id] [numeric](5, 0) IDENTITY(1,1) NOT NULL,
	[idCustomer] [numeric](3, 0) NOT NULL,
	[idCd] [numeric](5, 0) NOT NULL,
	[saleDate] [date] NOT NULL,
 CONSTRAINT [PK_Sales] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_1]    Script Date: 04/10/2020 18:52:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT        dbo.Cds.Album, dbo.Customers.Id
FROM            dbo.Cds INNER JOIN
                         dbo.Sales ON dbo.Cds.Id = dbo.Sales.idCd INNER JOIN
                         dbo.Customers ON dbo.Sales.idCustomer = dbo.Customers.Id
WHERE        (dbo.Customers.Id = 1)
GO
/****** Object:  View [dbo].[SalesView]    Script Date: 04/10/2020 18:52:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SalesView]
AS
SELECT        dbo.Customers.Id, dbo.Customers.Name, dbo.Customers.Surname, dbo.Cds.Album, dbo.Cds.Price, dbo.Cds.Storage, dbo.Sales.saleDate
FROM            dbo.Cds INNER JOIN
                         dbo.Sales ON dbo.Cds.Id = dbo.Sales.idCd INNER JOIN
                         dbo.Customers ON dbo.Sales.idCustomer = dbo.Customers.Id
GO
/****** Object:  View [dbo].[View_2]    Script Date: 04/10/2020 18:52:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_2]
AS
SELECT        dbo.Cds.Album, dbo.Cds.Price, dbo.Customers.Name, dbo.Customers.Surname, dbo.Sales.saleDate
FROM            dbo.Cds INNER JOIN
                         dbo.Sales ON dbo.Cds.Id = dbo.Sales.idCd INNER JOIN
                         dbo.Customers ON dbo.Sales.idCustomer = dbo.Customers.Id
WHERE        (dbo.Sales.saleDate > CONVERT(DATETIME, '2020-04-01 00:00:00', 102) AND dbo.Sales.saleDate < CONVERT(DATETIME, '2020-04-15 00:00:00', 102))
GO
SET IDENTITY_INSERT [dbo].[Cds] ON 

INSERT [dbo].[Cds] ([Id], [Album], [Singer], [Gerne], [Price], [Storage]) VALUES (CAST(8 AS Numeric(5, 0)), N'Master of Puppets', N'Metallica', N'Thrash Metal', 3.2, 8)
INSERT [dbo].[Cds] ([Id], [Album], [Singer], [Gerne], [Price], [Storage]) VALUES (CAST(9 AS Numeric(5, 0)), N'Paranoid', N'Black Sabbath', N'Heavy Metal', 3.99, 3)
INSERT [dbo].[Cds] ([Id], [Album], [Singer], [Gerne], [Price], [Storage]) VALUES (CAST(10 AS Numeric(5, 0)), N'The number of the Beast', N'Iron Maiden', N'Heavy Metal', 4.95, 6)
INSERT [dbo].[Cds] ([Id], [Album], [Singer], [Gerne], [Price], [Storage]) VALUES (CAST(11 AS Numeric(5, 0)), N'The Joshua Tree', N'U2', N'Rock', 7.75, 9)
SET IDENTITY_INSERT [dbo].[Cds] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [Name], [Surname], [FavoriteBand], [Email], [Phone]) VALUES (CAST(8 AS Numeric(3, 0)), N'Chris', N'Antoniou', N'Judas Priest', N'jd@asdas.com', CAST(99887766 AS Numeric(8, 0)))
INSERT [dbo].[Customers] ([Id], [Name], [Surname], [FavoriteBand], [Email], [Phone]) VALUES (CAST(9 AS Numeric(3, 0)), N'Antreas', N'Pelopida', N'Iron Maiden', N'iron@msn.com', CAST(99887755 AS Numeric(8, 0)))
INSERT [dbo].[Customers] ([Id], [Name], [Surname], [FavoriteBand], [Email], [Phone]) VALUES (CAST(10 AS Numeric(3, 0)), N'Antria', N'Panagi', N'Led Zeppelin', N'geia@gmail.com', CAST(99225588 AS Numeric(8, 0)))
INSERT [dbo].[Customers] ([Id], [Name], [Surname], [FavoriteBand], [Email], [Phone]) VALUES (CAST(11 AS Numeric(3, 0)), N'Rena', N'Renou', N'U2', N'ren@gmail,com', CAST(99887744 AS Numeric(8, 0)))
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[Sales] ON 

INSERT [dbo].[Sales] ([Id], [idCustomer], [idCd], [saleDate]) VALUES (CAST(18 AS Numeric(5, 0)), CAST(8 AS Numeric(3, 0)), CAST(8 AS Numeric(5, 0)), CAST(N'2020-04-09' AS Date))
INSERT [dbo].[Sales] ([Id], [idCustomer], [idCd], [saleDate]) VALUES (CAST(102 AS Numeric(5, 0)), CAST(11 AS Numeric(3, 0)), CAST(9 AS Numeric(5, 0)), CAST(N'2020-04-17' AS Date))
INSERT [dbo].[Sales] ([Id], [idCustomer], [idCd], [saleDate]) VALUES (CAST(103 AS Numeric(5, 0)), CAST(10 AS Numeric(3, 0)), CAST(9 AS Numeric(5, 0)), CAST(N'2020-04-10' AS Date))
SET IDENTITY_INSERT [dbo].[Sales] OFF
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Cds] FOREIGN KEY([idCd])
REFERENCES [dbo].[Cds] ([Id])
GO
ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Cds]
GO
ALTER TABLE [dbo].[Sales]  WITH CHECK ADD  CONSTRAINT [FK_Sales_Customers] FOREIGN KEY([idCustomer])
REFERENCES [dbo].[Customers] ([Id])
GO
ALTER TABLE [dbo].[Sales] CHECK CONSTRAINT [FK_Sales_Customers]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cds"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Sales"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SalesView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SalesView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cds"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Sales"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Cds"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Sales"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customers"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 624
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
USE [master]
GO
ALTER DATABASE [CdStore] SET  READ_WRITE 
GO
