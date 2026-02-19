import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//////////////////////////////////////////////////
// ROOT APP (GLOBAL THEME CONTROL)
//////////////////////////////////////////////////

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode =
      isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CS4458 Pro App",
      themeMode: _themeMode,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),

      home: LoginScreen(
        onThemeChanged: toggleTheme,
      ),
    );
  }
}

//////////////////////////////////////////////////
// LOGIN SCREEN
//////////////////////////////////////////////////

class LoginScreen extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const LoginScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";

  void login() {
    if (_formKey.currentState!.validate()) {
      if (email == "QuanNguyen@gmail.com" &&
          password == "29072004") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardScreen(
              email: email,
              onThemeChanged:
              widget.onThemeChanged,
            ),
          ),
        );
      } else {
        setState(() {
          error =
          "Invalid email or password";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
              Colors.black,
              Colors.grey.shade900
            ]
                : [
              Colors.blue.shade200,
              Colors.blue.shade50
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 12,
            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  20),
            ),
            child: Padding(
              padding:
              const EdgeInsets.all(
                  30),
              child: SizedBox(
                width: 350,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min,
                    children: [

                      const Icon(
                        Icons.lock,
                        size: 70,
                      ),

                      const SizedBox(
                          height: 20),

                      const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                            FontWeight
                                .bold),
                      ),

                      const SizedBox(
                          height: 25),

                      TextFormField(
                        decoration:
                        const InputDecoration(
                          labelText:
                          "Email",
                        ),
                        validator:
                            (value) {
                          if (value ==
                              null ||
                              value
                                  .isEmpty) {
                            return "Email required";
                          }
                          if (!value
                              .contains(
                              "@")) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        onChanged:
                            (value) =>
                        email =
                            value,
                      ),

                      const SizedBox(
                          height: 15),

                      TextFormField(
                        decoration:
                        const InputDecoration(
                          labelText:
                          "Password",
                        ),
                        obscureText:
                        true,
                        textInputAction:
                        TextInputAction
                            .done,
                        onFieldSubmitted:
                            (_) => login(),
                        validator:
                            (value) {
                          if (value ==
                              null ||
                              value
                                  .isEmpty) {
                            return "Password required";
                          }
                          return null;
                        },
                        onChanged:
                            (value) =>
                        password =
                            value,
                      ),

                      const SizedBox(
                          height: 25),

                      SizedBox(
                        width:
                        double.infinity,
                        child:
                        ElevatedButton(
                          onPressed:
                          login,
                          child:
                          const Padding(
                            padding:
                            EdgeInsets.symmetric(
                                vertical:
                                12),
                            child: Text(
                                "Login"),
                          ),
                        ),
                      ),

                      if (error
                          .isNotEmpty)
                        Padding(
                          padding:
                          const EdgeInsets.only(
                              top:
                              10),
                          child: Text(
                            error,
                            style:
                            const TextStyle(
                                color:
                                Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// DASHBOARD
//////////////////////////////////////////////////

class DashboardScreen extends StatefulWidget {
  final String email;
  final Function(bool) onThemeChanged;

  const DashboardScreen({
    super.key,
    required this.email,
    required this.onThemeChanged,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {

    String name =
    widget.email.split("@")[0];

    return Scaffold(
      body: Stack(
        children: [

          //////////////////////////////////////////////////
          // MAIN CONTENT
          //////////////////////////////////////////////////

          Padding(
            padding:
            const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                //////////////////////////////////////////////////
                // HEADER
                //////////////////////////////////////////////////

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          isHovering = true;
                        });
                      },
                      child: const Icon(
                        Icons.menu,
                        size: 30,
                      ),
                    ),

                    const Text(
                      "Dashboard",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    IconButton(
                      icon:
                      const Icon(Icons.logout),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                LoginScreen(
                                  onThemeChanged:
                                  widget
                                      .onThemeChanged,
                                ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                //////////////////////////////////////////////////
                // WELCOME CARD
                //////////////////////////////////////////////////

                Container(
                  padding:
                  const EdgeInsets.all(20),
                  decoration:
                  BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(20),
                    gradient:
                    LinearGradient(
                      colors:
                      Theme.of(context)
                          .brightness ==
                          Brightness.dark
                          ? [
                        Colors.blueGrey
                            .shade800,
                        Colors.black
                      ]
                          : [
                        Colors.blue,
                        Colors
                            .lightBlueAccent
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        child:
                        Icon(Icons.person),
                      ),
                      const SizedBox(
                          width: 15),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          const Text(
                            "Welcome",
                            style:
                            TextStyle(
                                color:
                                Colors.white),
                          ),
                          Text(
                            name,
                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //////////////////////////////////////////////////
                // GRID
                //////////////////////////////////////////////////

                Expanded(
                  child: LayoutBuilder(
                    builder:
                        (context,
                        constraints) {

                      int crossAxisCount =
                      constraints.maxWidth < 700
                          ? 1
                          : 3;

                      return GridView.count(
                        crossAxisCount:
                        crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: [

                          ProCard(
                            icon: Icons.person,
                            title: "Profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProfileScreen(
                                        email:
                                        widget.email,
                                      ),
                                ),
                              );
                            },
                          ),

                          ProCard(
                            icon: Icons.settings,
                            title: "Settings",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      SettingsScreen(
                                        onThemeChanged:
                                        widget
                                            .onThemeChanged,
                                      ),
                                ),
                              );
                            },
                          ),

                          ProCard(
                            icon: Icons.info,
                            title: "About",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      AboutScreen(
                                        email:
                                        widget.email,
                                      ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          //////////////////////////////////////////////////
          // SIDEBAR
          //////////////////////////////////////////////////

          AnimatedPositioned(
            duration:
            const Duration(milliseconds: 300),
            left: isHovering ? 0 : -220,
            top: 0,
            bottom: 0,
            child: MouseRegion(
              onExit: (_) {
                setState(() {
                  isHovering = false;
                });
              },
              child: Container(
                width: 220,
                color: Colors.black,
                child: Column(
                  children: [

                    const SizedBox(height: 80),

                    _buildMenuItem(
                        "Home",
                        Icons.home, () {}),

                    _buildMenuItem(
                        "Profile",
                        Icons.person, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProfileScreen(
                                email:
                                widget.email,
                              ),
                        ),
                      );
                    }),

                    _buildMenuItem(
                        "Settings",
                        Icons.settings, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SettingsScreen(
                                onThemeChanged:
                                widget
                                    .onThemeChanged,
                              ),
                        ),
                      );
                    }),

                    _buildMenuItem(
                        "About",
                        Icons.info, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AboutScreen(
                                email:
                                widget.email,
                              ),
                        ),
                      );
                    }),

                    const Spacer(),

                    _buildMenuItem(
                        "Logout",
                        Icons.logout, () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              LoginScreen(
                                onThemeChanged:
                                widget
                                    .onThemeChanged,
                              ),
                        ),
                      );
                    }),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////
  // SIDEBAR ITEM BUILDER
  //////////////////////////////////////////////////

  Widget _buildMenuItem(
      String title,
      IconData icon,
      VoidCallback onTap) {
    return ListTile(
      leading:
      Icon(icon, color: Colors.white),
      title: Text(
        title,
        style:
        const TextStyle(color: Colors.white),
      ),
      hoverColor: Colors.white12,
      onTap: onTap,
    );
  }
}


//////////////////////////////////////////////////
// PRO CARD
//////////////////////////////////////////////////

class ProCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
      BorderRadius.circular(20),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(
              20),
          color: Theme.of(context)
              .colorScheme
              .surfaceVariant,
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 50,
                color:
                Theme.of(context)
                    .colorScheme
                    .primary),
            const SizedBox(
                height: 15),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight
                        .w600)),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// PROFILE
//////////////////////////////////////////////////

class ProfileScreen extends StatelessWidget {
  final String email;

  const ProfileScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {

    String name = email.split("@")[0];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // AVATAR SECTION
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person, size: 60),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .primary,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 20),

            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              email,
              style: TextStyle(
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 30),

            // PERSONAL INFO CARD
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.badge),
                      title: Text("Role"),
                      subtitle: Text("Student"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text("Student ID"),
                      subtitle: Text("1677445"),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on),
                      title: Text("Location"),
                      subtitle: Text("Troy University"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // STATS SECTION
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                _StatCard(
                  title: "Courses",
                  value: "6",
                ),
                _StatCard(
                  title: "Credits",
                  value: "18",
                ),
                _StatCard(
                  title: "GPA",
                  value: "3.8",
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ABOUT ME
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Computer Science student currently enrolled in CS4458. "
                          "Interested in Flutter development, mobile applications, "
                          "and UI/UX design. Passionate about building modern apps.",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////
// STAT CARD WIDGET
//////////////////////////////////////////////////

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ),
              const SizedBox(height: 5),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}


//////////////////////////////////////////////////
// SETTINGS
//////////////////////////////////////////////////

class SettingsScreen extends StatelessWidget {
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {

    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            //////////////////////////////////////////////////
            // APPEARANCE SECTION
            //////////////////////////////////////////////////

            const Text(
              "Appearance",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Column(
                children: [

                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode),
                    title: const Text("Dark Mode"),
                    subtitle: const Text(
                        "Enable dark theme"),
                    value: isDark,
                    onChanged: (value) {
                      onThemeChanged(value);
                    },
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text("Language"),
                    subtitle: const Text("English"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //////////////////////////////////////////////////
            // NOTIFICATIONS
            //////////////////////////////////////////////////

            const Text(
              "Notifications",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: const Column(
                children: [
                  SwitchListTile(
                    secondary: Icon(Icons.notifications),
                    title: Text("Push Notifications"),
                    value: true,
                    onChanged: null,
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email Notifications"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //////////////////////////////////////////////////
            // ACCOUNT SECTION
            //////////////////////////////////////////////////

            const Text(
              "Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: Column(
                children: [

                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text("Change Password"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),

                  const Divider(),

                  ListTile(
                    leading: const Icon(Icons.privacy_tip),
                    title: const Text("Privacy Policy"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            //////////////////////////////////////////////////
            // ABOUT APP
            //////////////////////////////////////////////////

            const Text(
              "About",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 4,
              child: const ListTile(
                leading: Icon(Icons.info),
                title: Text("App Version"),
                subtitle: Text("2.0.0"),
              ),
            ),

            const SizedBox(height: 40),

            //////////////////////////////////////////////////
            // LOGOUT BUTTON
            //////////////////////////////////////////////////

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//////////////////////////////////////////////////
// ABOUT
//////////////////////////////////////////////////

class AboutScreen extends StatelessWidget {
  final String email;

  const AboutScreen({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    String developer = email.split("@")[0];
    bool isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //////////////////////////////////////////////////
            // HEADER SECTION
            //////////////////////////////////////////////////

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                    Colors.blueGrey.shade800,
                    Colors.black
                  ]
                      : [
                    Colors.blue,
                    Colors.lightBlueAccent
                  ],
                ),
              ),
              child: Column(
                children: const [
                  Icon(
                    Icons.flutter_dash,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "CS4458 Pro App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Version 2.0.0",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding:
              const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  //////////////////////////////////////////////////
                  // DEVELOPER CARD
                  //////////////////////////////////////////////////

                  Card(
                    elevation: 4,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(20),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .all(20),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          const Text(
                            "Developer",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                          const SizedBox(
                              height: 10),
                          Row(
                            children: [
                              const CircleAvatar(
                                child: Icon(
                                    Icons.person),
                              ),
                              const SizedBox(
                                  width: 15),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    developer,
                                    style:
                                    const TextStyle(
                                      fontSize:
                                      16,
                                      fontWeight:
                                      FontWeight
                                          .w600,
                                    ),
                                  ),
                                  Text(email),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  //////////////////////////////////////////////////
                  // COURSE INFO
                  //////////////////////////////////////////////////

                  Card(
                    elevation: 4,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(20),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .all(20),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: const [
                          Text(
                            "Course Information",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            leading: Icon(
                                Icons.school),
                            title:
                            Text("Course"),
                            subtitle:
                            Text("CS4458"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                                Icons
                                    .business),
                            title: Text(
                                "University"),
                            subtitle: Text(
                                "Troy University"),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(
                                Icons.calendar_today),
                            title:
                            Text("Year"),
                            subtitle:
                            Text("2026"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  //////////////////////////////////////////////////
                  // CONTACT
                  //////////////////////////////////////////////////

                  Card(
                    elevation: 4,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(20),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .all(20),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: const [
                          Text(
                            "Contact",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight
                                  .bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          ListTile(
                            leading:
                            Icon(Icons.email),
                            title: Text(
                                "Email"),
                            subtitle: Text(
                                "contact@cs4458.com"),
                          ),
                          Divider(),
                          ListTile(
                            leading:
                            Icon(Icons.web),
                            title: Text(
                                "Website"),
                            subtitle: Text(
                                "www.cs4458app.com"),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
