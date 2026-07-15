plugins {
  java
  id("com.gradleup.shadow") version "9.0.0-beta17"
}

group = "cn.villagetrader"
version = "1.1"

repositories {
  mavenCentral()
  maven("https://repo.papermc.io/repository/maven-public/")
}

dependencies {
  compileOnly("io.papermc.paper:paper-api:26.1.2.build.74-stable")
  implementation("com.google.code.gson:gson:2.13.1")
  testImplementation(platform("org.junit:junit-bom:5.13.3"))
  testImplementation("org.junit.jupiter:junit-jupiter")
  testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

java {
  toolchain.languageVersion.set(JavaLanguageVersion.of(25))
}

val asciiTestRoot = gradle.gradleUserHomeDir.resolve("caches/villagetrader-test-runtime-${projectDir.absolutePath.hashCode()}")
val prepareAsciiTestRuntime by tasks.registering {
  dependsOn(tasks.testClasses)
  doLast {
    val root = asciiTestRoot
    delete(root)
    copy {
      from(sourceSets.main.get().output)
      into(root.resolve("main"))
    }
    copy {
      from(sourceSets.test.get().output)
      into(root.resolve("test"))
    }
    copy {
      from(configurations.testRuntimeClasspath)
      into(root.resolve("libs"))
    }
  }
}

tasks {
  compileJava {
    options.encoding = "UTF-8"
    options.release.set(25)
  }
  processResources {
    filteringCharset = "UTF-8"
    filesMatching("plugin.yml") {
      expand("version" to project.version)
    }
  }
  test {
    dependsOn(prepareAsciiTestRuntime)
    useJUnitPlatform()
    doFirst {
      val root = asciiTestRoot
      testClassesDirs = files(root.resolve("test"))
      classpath = files(root.resolve("test"), root.resolve("main")) + fileTree(root.resolve("libs")) { include("*.jar") }
    }
  }
  shadowJar {
    archiveClassifier.set("")
    relocate("com.google.gson", "cn.villagetrader.libs.gson")
  }
  build { dependsOn(shadowJar) }
}
