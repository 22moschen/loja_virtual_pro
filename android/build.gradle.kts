buildscript {
    repositories {
        google()  // Adicione esta linha
        mavenCentral()  // E esta
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.3.0")  // Use a versão mais recente
        classpath("com.google.gms:google-services:4.4.2")  // Mantenha esta linha
    }
}

allprojects {
    repositories {
        google()  // Adicione aqui também
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
