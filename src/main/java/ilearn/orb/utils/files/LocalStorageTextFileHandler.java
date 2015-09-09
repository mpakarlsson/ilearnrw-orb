package ilearn.orb.utils.files;
/*
 * Copyright (c) 2015, iLearnRW. Licensed under Modified BSD Licence. See licence.txt for details.
 */
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Scanner;

public class LocalStorageTextFileHandler {
	public static InputStream loadInputStream(String resource) {
		try {
			return new FileInputStream(resource);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static InputStream saveInputStream(String resource,
			String fileContents) {
		try {
			PrintWriter out = new PrintWriter(resource);
			out.println(fileContents);
			out.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String loadAsString(String resource) {
		BufferedReader br = null;
		try {
			String sCurrentLine, text = "";
			br = new BufferedReader(new FileReader(resource));
			if ((sCurrentLine = br.readLine()) != null) {
				text = sCurrentLine;
			}
			while ((sCurrentLine = br.readLine()) != null) {
				text = text + "\n" + sCurrentLine;
			}
			return text;
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)
					br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return null;
	}

	public static String loadFileAsString(File file) {
		try {
			Scanner scanner = new Scanner(file);
			StringBuilder result = new StringBuilder("");
			while (scanner.hasNextLine()) {
				String line = scanner.nextLine();
				result.append(line).append("\n");
			}
			scanner.close();
			return result.toString();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
