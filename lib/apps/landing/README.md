# Landing Page Structure

This document explains the modular structure of the landing page components.

## Directory Structure

```
lib/apps/landing/
├── pages/
│   └── landing_page.dart              # Main landing page (entry point)
├── widgets/
│   ├── sections/                      # Page sections
│   │   ├── header_section.dart        # Navigation header
│   │   ├── hero_section.dart          # Hero/banner section
│   │   ├── work_experience_section.dart # Professional experience
│   │   ├── passion_projects_section.dart # Portfolio projects
│   │   ├── features_section.dart      # Technical features showcase
│   │   └── footer_section.dart        # Footer with contact info
│   └── components/                    # Reusable components
│       ├── experience_card.dart       # Work experience details
│       ├── project_card.dart          # Project showcase cards
│       ├── feature_card.dart          # Technical feature cards
│       ├── tech_timeline.dart         # Technology timeline
│       └── common_widgets.dart        # Shared utility widgets
├── models/
│   └── project_model.dart            # Data model for projects
├── services/
│   └── url_launcher_service.dart     # URL/link handling service
└── utils/
    └── responsive_utils.dart         # Responsive design utilities
```

## Key Components

### 1. Landing Page (`landing_page.dart`)
- **Purpose**: Main entry point and layout coordinator
- **Features**: 
  - Fade-in animation
  - Gradient background
  - Orchestrates all sections

### 2. Sections

#### Header Section (`header_section.dart`)
- **Purpose**: Navigation and branding
- **Features**:
  - Logo and name
  - Social media links
  - Responsive design

#### Hero Section (`hero_section.dart`)
- **Purpose**: Main introduction and call-to-action
- **Features**:
  - Professional avatar
  - Status indicator
  - Achievement banner
  - Action buttons

#### Work Experience Section (`work_experience_section.dart`)
- **Purpose**: Professional background showcase
- **Features**:
  - Experience card integration
  - Technology timeline

#### Passion Projects Section (`passion_projects_section.dart`)
- **Purpose**: Portfolio showcase
- **Features**:
  - Project cards
  - Responsive grid/column layout
  - Dynamic project data

#### Features Section (`features_section.dart`)
- **Purpose**: Technical capabilities showcase
- **Features**:
  - Feature cards with highlights
  - Grid layout
  - Color-coded categories

#### Footer Section (`footer_section.dart`)
- **Purpose**: Contact information and links
- **Features**:
  - Contact form integration
  - Social links
  - Copyright information

### 3. Components

#### Experience Card (`experience_card.dart`)
- **Purpose**: Detailed work experience display
- **Features**:
  - Implementation cards
  - Technology tags
  - Timeline integration

#### Project Card (`project_card.dart`)
- **Purpose**: Individual project showcase
- **Features**:
  - Status indicators
  - Technology tags
  - Action buttons (GitHub, Live demo)
  - Metrics display

#### Feature Card (`feature_card.dart`)
- **Purpose**: Technical feature presentation
- **Features**:
  - Gradient styling
  - Highlight lists
  - Icon-based design

#### Tech Timeline (`tech_timeline.dart`)
- **Purpose**: Technology progression visualization
- **Features**:
  - Timeline layout
  - Technology categorization
  - Color-coded sections

### 4. Services & Utils

#### URL Launcher Service (`url_launcher_service.dart`)
- **Purpose**: Centralized URL handling
- **Features**:
  - GitHub, LinkedIn, email links
  - App launch functionality
  - Error handling

#### Responsive Utils (`responsive_utils.dart`)
- **Purpose**: Screen size and layout utilities
- **Features**:
  - Device type detection
  - Responsive padding/sizing
  - Grid column calculations

#### Project Model (`project_model.dart`)
- **Purpose**: Data structure for projects
- **Features**:
  - Project metadata
  - Sample data provider
  - Type safety

## Benefits of This Structure

1. **Modularity**: Each component has a single responsibility
2. **Reusability**: Components can be reused across different pages
3. **Maintainability**: Easy to update individual sections without affecting others
4. **Testability**: Each component can be tested independently
5. **Scalability**: Easy to add new sections or modify existing ones
6. **Separation of Concerns**: Logic, UI, and data are clearly separated

## Usage Example

```dart
// Main landing page simply composes sections
class LandingPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderSection(),
            HeroSection(),
            WorkExperienceSection(),
            PassionProjectsSection(),
            FeaturesSection(),
            FooterSection(),
          ],
        ),
      ),
    );
  }
}
```

## Adding New Sections

To add a new section:

1. Create a new file in `widgets/sections/`
2. Implement as a `StatelessWidget` or `StatefulWidget`
3. Follow responsive design patterns using `ResponsiveUtils`
4. Add to the main `landing_page.dart` Column
5. Update this documentation

## Adding New Components

To add reusable components:

1. Create in `widgets/components/`
2. Make them configurable via constructor parameters
3. Follow existing design patterns
4. Consider responsive behavior
5. Add to relevant sections
