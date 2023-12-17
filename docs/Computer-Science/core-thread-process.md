# Computer Concepts (Program, Core, Process, Thread,...)

## **Programs**

**A program is a code that is stored on your computer that is intended to fulfill a certain task**. There are many types of programs, including programs that help your computer function and are part of the operating system, and other programs that fulfill a particular job. These task-specific programs are also known as “applications” and can include programs such as word processing, web browsing,...

Programs are typically stored on disk or in non-volatile memory in a form that can be executed by your computer. Prior to that, **they are created using a programming language using instructions that involve logic, data and device manipulation, recurrence, and user interaction.** The end result is a text file of code that is **compiled** into binary form (ones and zeros) in order to run on the computer. Another type of program is called **interpreted** and instead of being compiled in advance in order to run, is interpreted into executable code at the time it is run. Some common, typically interpreted programming languages, are Python, PHP, JavaScript, and Ruby.

## **Process**

The program has been loaded into the computer’s memory in binary form. Now what?

The program needs memory and various operating system resources in order to run. **A “process” is what we call a program that has been loaded into memory along with all the resources it needs to operate.** The “operating system” is the brains behind allocating all these resources. The OS handles the task of managing the resources needed to turn your program into a running process.

**There can be multiple instances of a single program, and each instance of that running program is a process. Each process has a separate memory address space, which means that a process runs independently and is isolated from other processes**. **It cannot directly access shared data in other processes.** Switching from one process to another requires some time (relatively) for saving and loading registers, memory maps, and other resources.

This independence of processes is valuable because the operating system tries its best to isolate processes so that a problem with one process doesn’t corrupt or cause havoc with another process. You’ve undoubtedly run into the situation in which one application on your computer freezes or has a problem and you’ve been able to quit that program without affecting others.

## **Thread**

**Thread is a single sequential flow of control in a program that allows multiple activities within a single process.** A single thread is like one command that runs at a time.

Most processor manufacturers use the Simultaneous multithreading (SMT) technique to make sure a single processer can run multiple threads. Multithreading is similar to multitasking in which multiple threads are executed at a time, and **a multithread ability manages numerous requests by the same user without opening multiple copies of programs running on the computer.**

A thread is a unit of execution on concurrent/parallel programming. **Multithreading is a technique which allows a CPU to execute many tasks of one process at the same time.** These threads can execute individually while sharing their resources.

### **How Threads Work**

A thread is the unit of execution within a process. A process can have from just one thread to many threads.

![Thread](/Learning-Journey/images/core-thread-process/thread.png)

When a process starts, it is assigned memory and resources. Each thread in the process shares that memory and resources. In single-threaded processes, the process contains one thread. The process and the thread are one and the same, and there is only one thing happening.

In multithreaded processes, the process contains more than one thread, and the process is accomplishing a number of things at the same time

![Thread vs MultiThread](/Learning-Journey/images/core-thread-process/single-thread-vs-multi.png)

Each thread will have its own stack.

**Threads are sometimes called lightweight processes** because they have their own stack but can access shared data. **Because threads share the same address space as the process and other threads within the process, the operational cost of communication between the threads is low, which is an advantage. The disadvantage is that a problem with one thread in a process will certainly affect other threads and the viability of the process itself.**

Review:

1. The program starts out as a text file of programming code.
2. The program is compiled or interpreted into binary form.
3. The program is loaded into memory.
4. The program becomes one or more running processes.
5. Processes are typically independent of each other.
6. Threads exist as the subset of a process.
7. Threads can communicate with each other more easily than processes can.
8. Threads are more vulnerable to problems caused by other threads in the same process.

### **Thread vs Process**

When Google was designing the Chrome browser, they needed to decide how to handle the many different tasks that needed computer, communications, and network resources at the same time. Each browser window or tab communicates with multiple servers on the internet to retrieve text, programs, graphics, audio, video, and other resources, and renders that data for display and interaction with the user. In addition, the browser can open many windows, each with many tasks.

Google had to decide how to handle that separation of tasks. They chose to run each browser window in Chrome as a separate process rather than a thread or many threads, as is common with other browsers. Doing that brought Google a number of benefits. Running each window as a process protects the overall application from bugs and glitches in the rendering engine and restricts access from each rendering engine process to others and to the rest of the system. Isolating a JavaScript program in a process prevents it from running away with too much CPU time and memory and making the entire browser non-responsive.

Google made a calculated trade-off with the multi-processing design. Starting a new process for each browser window has a higher fixed cost in memory and resources than using threads. They were betting that their approach would end up with less memory bloat overall.

Using processes instead of threads also provides better memory usage when memory gets low. An inactive window is treated as a lower priority by the operating system and becomes eligible to be swapped to disk when memory is needed for other processes. That helps keep the user-visible windows more responsive. If the windows were threaded, it would be more difficult to separate the used and unused memory as cleanly, wasting both memory and performance.

### **How Multithreading Works?**

For example, most modern CPUs support multithreading. A simple app on your smartphone can give you a live demo of the same.

When you open an app that requires some data to be fetched from the internet, the content area of the app is replaced by a spinner. This will rotates until the data is fetched and displayed.

In the background, there are two threads:

- One fetching the data from a network, and
- One rendering the GUI that displays the spinner

Both of these threads execute one after the other to give the illusion of concurrent execution

### **Working of Core and Thread**

The **core** is a hardware component and performs and has the ability to run one task at one time.

But **multiple cores** can support multiple applications to be executed without any disruptions.

If the user is planning to set up a game, some parts of cores are required to run the game, some needed to check other background applications like skype, chrome, Facebook, etc. **But the CPU should supports multithreading** to executes these effectively to fetch the relevant information from the application within a minimum response time. Multithreading just makes the process fast and organized, and convert into better performance. It increases power consumption but rarely causes a rise in temperature.

A CPU performance will depend upon the number of cores on the machine and the speed at which the individual cores can execute instructions.

## **Concurrency and Parallelism**

On a system with multiple processors or CPU cores (as is common with modern processors), multiple processes or threads can be executed in parallel. On a single processor, though, it is not possible to have processes or threads truly executing at the same time. In this case, the CPU is shared among running processes or threads using a process scheduling algorithm that divides the CPU’s time and yields the illusion of parallel execution. The time given to each task is called a “time slice.” The switching back and forth between tasks happens so fast it is usually not perceptible. The terms, “parallelism” (genuine simultaneous execution) and “concurrency” (interleaving of processes in time to give the appearance of simultaneous execution), distinguish between the two types of real or approximate simultaneous operation.

![Concurrency vs Parallelism](/Learning-Journey/images/core-thread-process/concurrency-vs-parallelism.png)

### **What is Concurrency or Single Core?**

a **Single-core CPU** will only be able to process one program at a time. However, when you run multiple programs simultaneously, then a single-core processor will divide all programs into small pieces and concurrently execute with time slicing, as you can view in the picture given below.

Concurrency is defined as the ability of a system to run two or more programs in overlapping time phases.

![Cores](/Learning-Journey/images/core-thread-process/cores.png)

Concurrent execution with time slicing

As you can see, at any given time, there is only one process in execution. Therefore, concurrency is only a generalized approximation of real parallel execution. This kind of situation can be found in systems having a single-core processor.

### **What is Parallel Execution or (Multi-Core)?**

A **Multicore processor** (multiple CPU cores) execute each sub-task simultaneously

In parallel execution, the tasks to be performed by a process are broken down into sub-parts, and multiple CPUs (or multiple cores) process each sub-task at precisely the same time.

![Cores](/Learning-Journey/images/core-thread-process/parallel.png)

As you can see, at any given time, all processes are in execution. In reality, it is the sub-tasks of a process which are executing in parallel, but for better understanding, you can visualize them as processes.

Therefore, parallelism is the real way in which multiple tasks can be processed at the same time. This type of situation can be found in systems having multicore processors, which includes almost all modern, commercial processors.

### **Key Differences**

• **Cores increase the amount of work accomplished at a time**, whereas **threads improve throughput, computational speed-up.**

• **Cores is an actual hardware component** whereas **thread is a virtual component that manages the tasks**.

• **Cores use content switching** while threads use multiple CPUs for operating numerous processes.

• Cores require only a signal process unit whereas threads require multiple processing units.

## **CPU Core**

A CPU core is the part of something central to its existence or character. In the same way in the computer system, the CPU is also referred to as the core.

There are basically two types of core processor:

1. Single-Core Processor
2. Multi-Core Processor

### **What is the Main Issue with Single Core?**

There are mainly two issues with Single Core.

- To execute the tasks faster, you need to increase the clock time.
- Increasing clock time increases power consumption and heat dissipation to an extremely high level, which makes the processor inefficient.

### **The Solution Provided by Multi-Core:**

- Creating two cores or more on the same die to increase the processing power while it also keeps clock speed at an efficient level.
- A processor with two cores running an efficient speed can process instructions with similar speed to the single-core processor. Its clock speed is twice, yet the multicore process consumes less energy.

### **Benefits of Multi-core Processor**

Here are some advantages of the multicore processor:

- More transistor per choice
- Shorter connections
- Lower capacitance
- A small circuit can work at fast speed

## **Compiler vs. Interpreter**

**Computers can only understand a program written in a binary system known as machine code.**

To speak to a computer in its non-human language, we came up with two solutions: interpreters and compilers. Ironically, most of us know very little about them, although they belong to our daily coding life.

A **compiler** is a computer program that transforms code written in a high-level programming language into the machine code. It is a program which translates the human-readable code to a language a computer processor understands (binary 1 and 0 bits). The computer processes the machine code to perform the corresponding tasks.

An interpreter is a computer program, which converts each high-level program statement into the machine code. This includes source code, pre-compiled code, and scripts. Both compiler and interpreters do the same job which is converting higher level programming language to machine code. However, a compiler will convert the code into machine code (create an exe) before program run. Interpreters convert code into machine code when the program is run.

- A compiler translates a code written in a high-level programming language into *a lower-level language like assembly language, object code, and* machine code (binary 1 and 0 bits). It converts the code ahead of time before the program runs.
- An interpreter translates the code line by line when the program is running. You’ve likely used interpreters unknowingly at some point in your work career.

![Compiler vs Interpreter](/Learning-Journey/images/core-thread-process/compiler-vs-interpreter.png)

Both compilers and interpreters have pros and cons:

- Compiler transforms code written in a high-level programming language into the machine code, at once, before program runs, whereas an Interpreter converts each high-level program statement, one by one, into the machine code, during program run.
- Compiled code runs faster while interpreted code runs slower.
- Compiler displays all errors after compilation, on the other hand, the Interpreter displays errors of each line one by one.
- Compiler is based on translation linking-loading model, whereas Interpreter is based on Interpretation Method.
- Compiler takes an entire program whereas the Interpreter takes a single line of code.

![Compiler vs Interpreter](/Learning-Journey/images/core-thread-process/compiler-program.png)

A high-level programming language is usually referred to as “compiled language” or “interpreted language.” However, in practice, they can have both compiled and interpreted implementations. C, for example, is called a compiled language, despite the existence of C interpreters. The first JavaScript engines were simple interpreters, but all modern engines use just-in-time (JIT) compilation for performance reasons.

## Refs

- [https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/](https://www.backblaze.com/blog/whats-the-diff-programs-processes-and-threads/)
